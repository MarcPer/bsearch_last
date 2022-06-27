require 'rake'
require 'rake/clean'

CLEAN.include(%w[Makefile bsearch_last.o bsearch_last.so])
ENV['RUBYLIB'] = ".#{File::PATH_SEPARATOR}#{ENV['RUBYLIB']}"

task default: [:spec]
task :build =>[:clean] do
  sh %{ruby extconf.rb}
  sh %{make}
end

task spec: [:build] do
  sh "ruby -I . spec/bsearch_last_test.rb"
end

task bench: [:build] do
  sh "ruby -I . spec/benchmark.rb"
end
