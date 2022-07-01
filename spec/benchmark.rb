#!/usr/bin/env ruby

require 'benchmark/ips'
require 'bsearch_last'

def run_bench(arr, &block)
  Benchmark.ips do |x|
    x.report("C") { arr._bsearch_last_index(&block) }
    x.report("Ruby") { arr.bsearch_last_index(&block) }
  end
end

arr = Array.new(100){0}+Array.new(100){1}+Array.new(100){2}
block = ->(x) { x <= 1 }
run_bench(arr, &block)
