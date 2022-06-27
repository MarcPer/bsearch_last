#!/usr/bin/env ruby

require 'benchmark/ips'
require 'bsearch_last'

def run_bench(arr, target)
  Benchmark.ips do |x|
    x.report("C") { arr._bsearch_last_index(target) }
    x.report("Ruby") { arr.bsearch_last_index(target) }
  end
end

arr = Array.new(100){0}+Array.new(100){1}+Array.new(100){2}
target = 1
run_bench(arr, target)
