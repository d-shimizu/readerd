# -*- encoding: utf-8 -*-
# stub: sax-machine 1.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sax-machine"
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Paul Dix", "Julien Kirch", "Ezekiel Templin", "Dmitry Krasnoukhov"]
  s.date = "2015-04-19"
  s.email = "paul@pauldix.net"
  s.homepage = "http://github.com/pauldix/sax-machine"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.0"
  s.summary = "Declarative SAX Parsing with Nokogiri, Ox or Oga"

  s.installed_by_version = "2.5.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.0"])
  end
end
