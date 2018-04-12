# -*- encoding: utf-8 -*-
# stub: zip_tricks 4.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "zip_tricks".freeze
  s.version = "4.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Julik Tarkhanov".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-11-06"
  s.description = "Stream out ZIP files from Ruby".freeze
  s.email = ["me@julik.nl".freeze]
  s.homepage = "http://github.com/wetransfer/zip_tricks".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Stream out ZIP files from Ruby".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1"])
      s.add_development_dependency(%q<rubyzip>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<terminal-table>.freeze, [">= 0"])
      s.add_development_dependency(%q<range_utils>.freeze, [">= 0"])
      s.add_development_dependency(%q<rack>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_development_dependency(%q<complexity_assert>.freeze, [">= 0"])
      s.add_development_dependency(%q<coderay>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.51.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1"])
      s.add_dependency(%q<rubyzip>.freeze, ["~> 1.1"])
      s.add_dependency(%q<terminal-table>.freeze, [">= 0"])
      s.add_dependency(%q<range_utils>.freeze, [">= 0"])
      s.add_dependency(%q<rack>.freeze, ["~> 1.6"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_dependency(%q<complexity_assert>.freeze, [">= 0"])
      s.add_dependency(%q<coderay>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.51.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 1.1"])
    s.add_dependency(%q<terminal-table>.freeze, [">= 0"])
    s.add_dependency(%q<range_utils>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3"])
    s.add_dependency(%q<complexity_assert>.freeze, [">= 0"])
    s.add_dependency(%q<coderay>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.51.0"])
  end
end
