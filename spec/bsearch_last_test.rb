require 'bsearch_last'
require 'minitest/autorun'

class BSearchTest < Minitest::Test
  SPECS = [
    {arr: [1, 1, 1], target: 1, want: 2},
    {arr: [1, 1, 1], target: 2, want: nil},
    {arr: [1, 2, 3, 3, 4, 4], target: 3, want: 3},
    {arr: Array.new(100){0}+Array.new(100){1}+Array.new(100){2}, target: 1, want: 199},
  ]

  def test_bsearch_last_index
    SPECS.each do |spec|
      out = spec[:arr].bsearch_last_index(spec[:target])
      assert_equal spec[:want], out, "input arr=#{spec[:arr]}, target=#{spec[:target]}"
    end
  end
end

