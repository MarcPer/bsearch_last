# frozen_string_literal: true

class Array
  def bsearch_last_index(val)
    if respond_to?(:_bsearch_last_index, true)
      return _bsearch_last_index(val)
    end

    max = self.size-1
    min = 0
    while min < max
      mid = (max+min)/2+1
      if self[mid] <= val
        min = mid
      else
        max = mid-1
      end
    end

    self[max] == val ? max : nil
  end

  def bsearch_last(val)
    idx = bsearch_last_index(val)
    idx ? self[idx] : idx
  end
end

begin
  require 'bsearch_last.so'
rescue LoadError
end

