require 'bsearch_last'
require 'minitest/autorun'

class BSearchTest < Minitest::Test
  def test_bsearch_last_find_maximum
    specs = [
      {arr: [1, 1, 1], proc: ->(x){x >= 1}, want_idx: 2},
      {arr: [0, 4, 4, 7, 10, 12], proc: ->(x){x <= 4}, want_idx: 2},
      {arr: [1, 1, 1], proc: ->(x){x < 0}, want_idx: nil},
    ]

    specs.each do |spec|
      arr = spec[:arr]
      out_idx = arr.bsearch_last_index(&spec[:proc])
      out = spec[:arr].bsearch_last(&spec[:proc])

      if spec[:want_idx].nil?
        assert_nil out_idx, "wrong index; input arr=#{arr}"
        assert_nil out, "wrong element; input arr=#{arr}"
      else
        assert_equal spec[:want_idx], out_idx, "wrong index; input arr=#{arr}"
        assert_equal arr[spec[:want_idx]], out, "wrong element; input arr=#{spec[:arr]}"
      end
    end
  end

  def test_bsearch_last_find_any
    specs = [
      {arr: [0, 4, 7, 10, 12], proc: ->(x){7 <=> x}, want_idx: 2},
      {arr: [0, 4, 7, 10, 12], proc: ->(x){12 <=> x}, want_idx: 4},
      {arr: [0, 4, 7, 10, 12], proc: ->(x){-1 <=> x}, want_idx: nil},
      {arr: [0, 4, 7, 10, 12], proc: ->(x){5 <=> x}, want_idx: nil},
      {arr: [0, 4, 7, 10, 12], proc: ->(x){15 <=> x}, want_idx: nil},

      {arr: [0, 100, 100, 100, 200], proc: ->(x){100-x}, want_idx: 3},
      {arr: [0, 100, 100, 100, 200], proc: ->(x){200-x}, want_idx: 4},
      {arr: [0, 100, 100, 100, 200], proc: ->(x){300-x}, want_idx: nil},
      {arr: [0, 100, 100, 100, 200], proc: ->(x){50-x}, want_idx: nil},
    ]

    specs.each do |spec|
      arr = spec[:arr]
      out_idx = arr.bsearch_last_index(&spec[:proc])
      out = spec[:arr].bsearch_last(&spec[:proc])

      if spec[:want_idx].nil?
        assert_nil out_idx, "wrong index; input arr=#{arr}"
        assert_nil out, "wrong element; input arr=#{arr}"
      else
        assert_equal spec[:want_idx], out_idx, "wrong index; input arr=#{arr}"
        assert_equal arr[spec[:want_idx]], out, "wrong element; input arr=#{spec[:arr]}"
      end
    end
  end
end

