spec = Gem::Specification.new do |s|
  s.name = "bsearch_last"
  s.version = "0.0.1"
  s.author = "Marcelo Pereira"
  s.homepage = "https://github.com/MarcPer/bsearch_last"
  s.platform = Gem::Platform::RUBY
  s.summary = "Binary search for arrays that returns the last matching element"
  s.files = %w[LICENSE extconf.rb bsearch_last.c bsearch_last.rb spec/bsearch_last_test.rb]
  s.require_paths = ["."]
  s.extensions << 'extconf.rb'
  s.test_files = %w[spec/bsearch_last_test.rb]
  s.add_development_dependency "benchmark-ips"
end

