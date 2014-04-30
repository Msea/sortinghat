require 'pry'
module SortingHat

  class Sorter

    module MergeSorter

      @original = ((1..10_000).to_a.shuffle)

      def merge_sort(start = 0, endpoint = @original.size - 1)
        
        range = endpoint - start
        
        @other_arr ||= Array.new(@original.size)
        return [@other_arr[start] = @original[start]].compact if range <= 0

        midpoint = start + range/2 + 1
        
        merge_sort(start, midpoint - 1)
        merge_sort(midpoint, endpoint)

        counter1, counter2 = start, midpoint


        (start..endpoint).each do |position|
          first_op = @other_arr[counter1]
          second_op = @other_arr[counter2]
          if counter1 < midpoint &&
            (counter2 > endpoint || first_op <= second_op)
            

            @original[position] = first_op
            counter1 += 1
          else
            @original[position] = second_op
            counter2 += 1
          end
        end

        @other_arr[start..endpoint] = @original[start..endpoint]
      end

    end

  end

  class PseudoArray

    def initialize(arr, start = 0, stop = arr.size - 1)
      @arr = arr
      @start = start
      @stop = stop
    end

    def [](index)
      return if index + @start > @stop
      if index < 1
        arr[@stop + index + 1]
      else
        arr[index + @start]
      end
    end

    def []=(index, value)
      return if index + @start > @stop
      if index < 1
        arr[@stop + index + 1] = value
      else
        arr[index + @start] = value
      end
    end

  end
end