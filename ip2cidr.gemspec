Gem::Specification.new do |s|
  s.name                = "ip2cidr"
  s.version             = "0.0.2"
  s.executables         << 'ip2cidr'
  s.date                = %q{2015-04-28}
  s.summary             = %q{Converts IP Range to CIDR}
  s.description         = %q{Converts a range of IP Adrresses to a list of CIDR Adresses}
  s.authors             = ["Carlo Niño A. Bitoon", "Kirk Gandril B. Madraga", "John Patrick Suelto"]
  s.email               = ["carloninobitoon@yahoo.com","kirkmadraga@outlook.com","jp_suelto@yahoo.com"]
  s.files               = ["lib/ip2cidr.rb", "lib/ip2cidr/iphandling.rb"]
  s.test_files          = ["test/test_ip2cidr.rb"]
  s.require_paths       = ["lib"]
  s.homepage            = %q{http://rubygems.org/gems/iptocidr}
  s.license             = ''
end