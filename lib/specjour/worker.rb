module Specjour
  class Worker
    include Protocol
    attr_accessor :printer_uri
    attr_reader :project_path, :specs_to_run, :number, :batch_size

    def initialize(project_path, printer_uri, number, batch_size)
      @project_path = project_path
      @specs_to_run = specs_to_run
      @number = number.to_i
      @batch_size = batch_size.to_i
      self.printer_uri = printer_uri
      GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)
      DRb
      Rspec::DistributedFormatter.batch_size = batch_size
      Cucumber::DistributedFormatter.batch_size = batch_size
      ::Cucumber::Cli::Options.class_eval { def print_profile_information; end }
      Dir.chdir(project_path)
      set_env_variables
    end

    def printer_uri=(val)
      @printer_uri = URI.parse(val)
    end

      require 'benchmark'
    def run
      printer.send_message(:ready)
      time = Benchmark.realtime do
      while !printer.closed? && data = printer.gets(TERMINATOR)
        spec = load_object(data)
        if spec
          run_test spec
          printer.send_message(:ready)
        else
          printer.send_message(:done)
          printer.close
        end
      end
      end
      Kernel.puts time
    end

    protected

    def printer
      @printer ||= printer_connection
    end

    def printer_connection
      TCPSocket.open(printer_uri.host, printer_uri.port).extend Protocol
    end

    def run_test(test)
      if test =~ /.feature/
        run_feature test
      else
        run_spec test
      end
    end

    def run_feature(feature)
      Kernel.puts "Running #{feature}"
      cli = ::Cucumber::Cli::Main.new(['--format', 'Specjour::Cucumber::DistributedFormatter', feature], printer_connection)
      cli.execute!(::Cucumber::Cli::Main.step_mother)
    end

    def run_spec(spec)
      Kernel.puts "Running #{spec}"
      options = Spec::Runner::OptionParser.parse(
        ['--format=Specjour::Rspec::DistributedFormatter', spec],
        $stderr,
        printer_connection
      )
      Spec::Runner.use options
      options.run_examples
      Spec::Runner.options.instance_variable_set(:@examples_run, true)
    end

    def set_env_variables
      ENV['PREPARE_DB'] = 'true'
      ENV['RSPEC_COLOR'] = 'true'
      if number > 1
        ENV['TEST_ENV_NUMBER'] = number.to_s
      else
        ENV['TEST_ENV_NUMBER'] = nil
      end
    end
  end
end
