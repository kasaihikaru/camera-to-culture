# -*- encoding: utf-8 -*-
# stub: zipline 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "zipline".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ram Dobson".freeze]
  s.date = "2018-01-08"
  s.description = "a module for streaming dynamically generated zip files".freeze
  s.email = ["ram.dobson@solsystemscompany.com".freeze]
  s.homepage = "http://github.com/fringd/zipline".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "stream zip files from rails".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<zip_tricks>.freeze, ["<= 5.0.0", ">= 4.2.1"])
      s.add_runtime_dependency(%q<rails>.freeze, ["< 5.2", ">= 3.2.1"])
      s.add_runtime_dependency(%q<curb>.freeze, ["< 0.10", ">= 0.8.0"])
    else
      s.add_dependency(%q<zip_tricks>.freeze, ["<= 5.0.0", ">= 4.2.1"])
      s.add_dependency(%q<rails>.freeze, ["< 5.2", ">= 3.2.1"])
      s.add_dependency(%q<curb>.freeze, ["< 0.10", ">= 0.8.0"])
    end
  else
    s.add_dependency(%q<zip_tricks>.freeze, ["<= 5.0.0", ">= 4.2.1"])
    s.add_dependency(%q<rails>.freeze, ["< 5.2", ">= 3.2.1"])
    s.add_dependency(%q<curb>.freeze, ["< 0.10", ">= 0.8.0"])
  end
end
