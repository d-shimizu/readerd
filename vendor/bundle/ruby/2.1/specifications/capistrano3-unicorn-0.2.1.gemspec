# -*- encoding: utf-8 -*-
# stub: capistrano3-unicorn 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano3-unicorn"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Matthew Lineen"]
  s.date = "2014-07-16"
  s.description = "Unicorn specific Capistrano tasks"
  s.email = ["matthew@lineen.com"]
  s.homepage = "https://github.com/tablexi/capistrano3-unicorn"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.0"
  s.summary = "Unicorn specific Capistrano tasks"

  s.installed_by_version = "2.5.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 3.1.0", "~> 3.1"])
    else
      s.add_dependency(%q<capistrano>, [">= 3.1.0", "~> 3.1"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 3.1.0", "~> 3.1"])
  end
end
