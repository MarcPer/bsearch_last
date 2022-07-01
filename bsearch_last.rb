# frozen_string_literal: true

class Array
  def bsearch_last_index(&block)
    if respond_to?(:_bsearch_last_index, true)
      return _bsearch_last_index(&block)
    end

    max = self.size-1
    min = 0
    greater = false
    satisfied = false

    while min < max
      mid = (max+min)/2+1
      v = yield(self[mid])

      if v.is_a?(Numeric)
        case v <=> 0
        when 0 then return mid
        when 1 then greater = true
        when -1 then greater = false
        end
      elsif v.is_a?(TrueClass)
        greater = true
        satisfied = true
      else
        greater = false
      end

      greater ? min = mid : max = mid-1
    end

    satisfied ? max : nil
  end

  def bsearch_last(&block)
    if respond_to?(:_bsearch_last, true)
      return _bsearch_last(&block)
    end

    idx = bsearch_last_index(&block)
    idx ? self[idx] : idx
  end
end

begin
  require 'bsearch_last.so'
rescue LoadError
end

