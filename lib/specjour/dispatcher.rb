module Specjour
  class Dispatcher
    attr_reader :project_path, :workers, :worker_threads, :hosts

    def initialize(project_path)
      @project_path = project_path
      @workers = []
      @worker_threads = []
      @hosts = {}
    end

    def all_specs
      @all_specs ||= Dir.chdir(project_path) do
        Dir["spec/**/*_spec.rb"].sort_by { rand }
      end
    end

    def project_name
      File.basename(project_path)
    end

    def start
      rsync_daemon.start
      gather_workers
      sync_workers
      dispatch_work
      wait_on_workers
      sleep 2
      rsync_daemon.stop
    end

    protected

    def add_worker_to_hosts(worker, host)
      if hosts[host]
        hosts[host] << worker
      else
        hosts[host] = [worker]
      end
    end

    def browser
      @browser ||= DNSSD::Service.new
    end

    def dispatch_work
      workers.each_with_index do |worker, index|
        worker.specs_to_run = Array(specs_for_worker(index))
        worker_threads << Thread.new(worker, &work)
      end
    end

    def sync_workers
      workers.each do |worker|
        worker.sync
      end
      puts "done syncing"
    end

    def gather_workers
      browser.browse '_druby._tcp' do |reply|
        DNSSD.resolve(reply) do |resolved|
          uri = URI::Generic.build :scheme => reply.service_name, :host => resolved.target, :port => resolved.port
          workers << fetch_worker(uri)
          reply.service.stop unless reply.flags.more_coming?
        end
      end
      p workers
    end

    def fetch_worker(uri)
      worker = DRbObject.new_with_uri(uri.to_s)
      add_worker_to_hosts(worker, uri.host)
      worker.project_name = project_name
      worker.host = %x(hostname).strip
      worker.number = hosts[uri.host].index(worker) + 1
      worker
    end

    def rsync_daemon
      @rsync_daemon ||= RsyncDaemon.new(project_path, project_name)
    end

    def specs_per_worker
      per = all_specs.size / workers.size
      per.zero? ? 1 : per
    end

    def specs_for_worker(index)
      offset = (index * specs_per_worker)
      boundry = specs_per_worker * (index + 1)
      range = (offset...boundry)
      if workers[index] == workers.last
        range = (offset..-1)
      end
      all_specs[range]
    end

    def wait_on_workers
      worker_threads.each {|t| t.join}
    end

    def work
      lambda do |worker|
        puts worker.run
      end
    end
  end
end
