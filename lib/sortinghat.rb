```
Tasks for the class:
1) sort enumerable
2) sort_by &block
3) autosort (analyze data, pick correct sort)
4) optimize_sort (optional symbols, otherwise use default sorts)
```

require "benchmark"
require "sortinghat/version"
require "sortinghat/heapsorter"

module SortingHat
  class Sorter
    include HeapSorter
    include MergeSorter

    attr_reader :original

    def initialize(enum)
      @original = enum.dup.to_a
    end

    def sort
      @original.sort
    end

    def sort_by(method, &block)
      self.send(method, &block)
    end
    private :sort_by

    # .heapsort_by(&block)
    def method_missing(meth, *args, &block)
      meth = meth.to_s
      if meth.end_with?("sort_by")
        sort_by(meth[0..-4], &block)
      else
        super
      end
    end
  end
end

s = Sortinghat::Sorter.new([1,2,3])
s.heapsort
s.heapsort
Sortinghat::Sorter.new([1,2,3]).optimize_sort(:heapsort, :mergesort)