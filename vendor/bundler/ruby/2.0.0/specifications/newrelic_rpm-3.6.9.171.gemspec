# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "newrelic_rpm"
  s.version = "3.6.9.171"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Clark", "Sam Goldstein", "Jonan Scheffler", "Ben Weintraub"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDODCCAiCgAwIBAgIBADANBgkqhkiG9w0BAQUFADBCMREwDwYDVQQDDAhzZWN1\ncml0eTEYMBYGCgmSJomT8ixkARkWCG5ld3JlbGljMRMwEQYKCZImiZPyLGQBGRYD\nY29tMB4XDTEzMDIxMjE5MDcwN1oXDTE0MDIxMjE5MDcwN1owQjERMA8GA1UEAwwI\nc2VjdXJpdHkxGDAWBgoJkiaJk/IsZAEZFghuZXdyZWxpYzETMBEGCgmSJomT8ixk\nARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJyYRvlk1XUo\n8JhWQcE/v6RmpK//JbeKvTKnmWVUKz5oTDSOg/LKEhzChpJJVSOMJHCxd4OoxkIN\npjQF5U2af1m5ONeN1j4p4MujbwNeqxsJmixGLK/BZ9xTnbpYAa6xCRN1UfEcu3O9\njjLHX3c63ghldwRBn/c2ZD6anMtDeq3C5MLiycFs9h7JXOa3cTTHLZknkYIoHMKN\nEFri5zlks50lbeaVvFRm4IMrYWRsEwzLZWaMOy68BVZe0UlBBKSMnzJfWkbdRRcm\nxqu7viu4hrrCGjUmdHKnl6tf7BY7wqQyKjj+O5DhayKmKRuQcEX8QVnsM+ayqiVU\nEtMiwNScUnsCAwEAAaM5MDcwCQYDVR0TBAIwADAdBgNVHQ4EFgQUOauaMsU0Elp6\nhiUisj4l63ZunSUwCwYDVR0PBAQDAgSwMA0GCSqGSIb3DQEBBQUAA4IBAQAuwrHh\njOjIfAQoEbGakiwHTeImqmC1EjBEWb1+U+rC2OcsSQ3+2Q0mGq2u3lAphAeLa6i5\nWXb5OdQqZY2aI7NgMxRG98/+TcIlAT8tDR0e6/+QBlBuDXP3YI5Nuhp5U4LEvghr\njEPaEo0AFPc1JpSO/zKmktU+e9VRAE+q55gLthP8fe0uZvtGUn0KgDbXJyOuGlHF\nJ93N937OcyA2rD8gR1qkr3/0/we1dwLZnL6kN4p8nGzPgXZgOHsmTdYZ2ryYowtb\nKc9+v+QxnbZYpu2IaPXOvm3T8G4O6qZvhnLh/Uien++Dj8eFBecTPoM8pVjK3ph5\nn/EwuZCcE6ghtCCM\n-----END CERTIFICATE-----\n"]
  s.date = "2013-11-07"
  s.description = "New Relic is a performance management system, developed by New Relic,\nInc (http://www.newrelic.com).  New Relic provides you with deep\ninformation about the performance of your web application as it runs\nin production. The New Relic Ruby Agent is dual-purposed as a either a\nGem or plugin, hosted on\nhttp://github.com/newrelic/rpm/\n"
  s.email = "support@newrelic.com"
  s.executables = ["mongrel_rpm", "newrelic_cmd", "newrelic", "nrdebug"]
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.md", "GUIDELINES_FOR_CONTRIBUTING.md", "newrelic.yml"]
  s.files = ["bin/mongrel_rpm", "bin/newrelic_cmd", "bin/newrelic", "bin/nrdebug", "CHANGELOG", "LICENSE", "README.md", "GUIDELINES_FOR_CONTRIBUTING.md", "newrelic.yml"]
  s.homepage = "http://www.github.com/newrelic/rpm"
  s.post_install_message = "# New Relic Ruby Agent Release Notes #\n\n## v3.6.9 ##\n\n* Experimental Rubinius 2.x support\n\n  The agent is now being tested against the latest version of Rubinius. While\n  support is still considered experimental, you can track the progress at\n  http://docs.newrelic.com/docs/ruby/rubinius for up to date status.\n\n* Capture arguments for Resque and Sidekiq jobs\n\n  The agent can optionally record arguments for your Resque and Sidekiq jobs on\n  transaction traces and traced errors. This is disabled by default, but may be\n  enabled by setting resque.capture_params or sidekiq.capture_params.\n\n  Thanks to Juan Ignacio Pumarino, Ken Mayer, Paul Henry, and Eric Saxby for\n  their help with this feature!\n\n* Supported versions rake task and documentation\n\n  We've improved our documentation for what Ruby and gem versions we support.\n  Run `rake newrelic:supported_versions` or see the latest agent's versions at\n  https://docs.newrelic.com/docs/ruby/supported-frameworks.\n\n* ActiveRecord 4.0 explain plans for JRuby and Rubinius\n\n  The agent's ActiveRecord 4.0 instrumentation could not gather SQL explain\n  plans on JRuby by default because of a dependency on ObjectSpace, which isn't\n  avialable by default. This has been fixed.\n\n* Fix for Curb http_put_with_newrelic\n\n  A bug in the agent caused PUT calls in the Curb gem to crash. This has been\n  fixed. Thanks to Michael D'Auria and Kirk Diggler for the contributions!\n\n* Fix for head position on RUM injection\n\n  Certain unusual HTML documents resulted in browser monitoring injecting\n  incorrect content. Thanks Alex McHale for the contribution!\n\n* Specify the Content-Type header in developer mode\n\n  Thanks Jared Ning for the contribution!\n\nSee https://github.com/newrelic/rpm/blob/master/CHANGELOG for a full list of\nchanges.\n"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "New Relic Ruby Agent"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.2"
  s.summary = "New Relic Ruby Agent"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["= 10.1.0"])
      s.add_development_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_development_dependency(%q<mocha>, ["~> 0.13.0"])
      s.add_development_dependency(%q<sdoc-helpers>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_development_dependency(%q<rails>, ["~> 3.2.13"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<sequel>, ["~> 3.46.0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<guard>, ["~> 1.8.3"])
      s.add_development_dependency(%q<guard-test>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
    else
      s.add_dependency(%q<rake>, ["= 10.1.0"])
      s.add_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_dependency(%q<mocha>, ["~> 0.13.0"])
      s.add_dependency(%q<sdoc-helpers>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_dependency(%q<rails>, ["~> 3.2.13"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<sequel>, ["~> 3.46.0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<guard>, ["~> 1.8.3"])
      s.add_dependency(%q<guard-test>, ["~> 1.0.0"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
    end
  else
    s.add_dependency(%q<rake>, ["= 10.1.0"])
    s.add_dependency(%q<minitest>, ["~> 4.7.5"])
    s.add_dependency(%q<mocha>, ["~> 0.13.0"])
    s.add_dependency(%q<sdoc-helpers>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 2.4.2"])
    s.add_dependency(%q<rails>, ["~> 3.2.13"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<sequel>, ["~> 3.46.0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<guard>, ["~> 1.8.3"])
    s.add_dependency(%q<guard-test>, ["~> 1.0.0"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
  end
end
