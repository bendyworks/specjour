# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{specjour}
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sandro Turriate"]
  s.date = %q{2010-05-10}
  s.default_executable = %q{specjour}
  s.description = %q{Distribute your spec suite amongst your LAN via Bonjour.}
  s.email = %q{sandro.turriate@gmail.com}
  s.executables = ["specjour"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".dev",
     ".document",
     ".gitignore",
     "History.markdown",
     "MIT_LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "bin/specjour",
     "lib/specjour.rb",
     "lib/specjour/connection.rb",
     "lib/specjour/cpu.rb",
     "lib/specjour/cucumber.rb",
     "lib/specjour/cucumber/dispatcher.rb",
     "lib/specjour/cucumber/distributed_formatter.rb",
     "lib/specjour/cucumber/final_report.rb",
     "lib/specjour/cucumber/printer.rb",
     "lib/specjour/db_scrub.rb",
     "lib/specjour/dispatcher.rb",
     "lib/specjour/manager.rb",
     "lib/specjour/printer.rb",
     "lib/specjour/protocol.rb",
     "lib/specjour/rspec.rb",
     "lib/specjour/rspec/distributed_formatter.rb",
     "lib/specjour/rspec/final_report.rb",
     "lib/specjour/rspec/marshalable_rspec_failure.rb",
     "lib/specjour/rsync_daemon.rb",
     "lib/specjour/socket_helpers.rb",
     "lib/specjour/tasks/dispatch.rake",
     "lib/specjour/tasks/specjour.rb",
     "lib/specjour/worker.rb",
     "rails/init.rb",
     "spec/cpu_spec.rb",
     "spec/lib/specjour/worker_spec.rb",
     "spec/manager_spec.rb",
     "spec/rsync_daemon_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/specjour_spec.rb",
     "specjour.gemspec"
  ]
  s.homepage = %q{http://github.com/sandro/specjour}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Distribute your spec suite amongst your LAN via Bonjour.}
  s.test_files = [
    "spec/cpu_spec.rb",
     "spec/lib/specjour/worker_spec.rb",
     "spec/manager_spec.rb",
     "spec/rsync_daemon_spec.rb",
     "spec/spec_helper.rb",
     "spec/specjour_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dnssd>, ["= 1.3.1"])
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_development_dependency(%q<rr>, ["= 0.10.11"])
      s.add_development_dependency(%q<yard>, ["= 0.5.3"])
    else
      s.add_dependency(%q<dnssd>, ["= 1.3.1"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_dependency(%q<rr>, ["= 0.10.11"])
      s.add_dependency(%q<yard>, ["= 0.5.3"])
    end
  else
    s.add_dependency(%q<dnssd>, ["= 1.3.1"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 1.3.0"])
    s.add_dependency(%q<rr>, ["= 0.10.11"])
    s.add_dependency(%q<yard>, ["= 0.5.3"])
  end
end

