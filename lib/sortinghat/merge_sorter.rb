require 'pry'
module SortingHat

  class Sorter

    module MergeSorter

      def merge_sort(arr = @original)
        return @sorted if @sorted
        
        case arr.size
        when 1
          arr
        when 2
          arr[0] < arr[1] ? arr : arr.reverse!
        else
          first_half = merge_sort(arr[0...(arr.size/2)])
          second_half = merge_sort(arr[(arr.size/2)..-1])
          
          to_return = []
          cur_objs = [first_half.shift, second_half.shift]
          
          until first_half.empty? || second_half.empty?
            if cur_objs[0] < cur_objs[1]
              to_return << cur_objs[0]
              cur_objs[0] = first_half.shift
            else
              to_return << cur_objs[1]
              cur_objs[1] = second_half.shift
            end
          end
          
          if first_half.empty?
            while !second_half.empty? && cur_objs[1] < cur_objs[0]
              to_return << cur_objs[1]
              cur_objs[1] = second_half.shift
            end
            to_return += cur_objs.sort
            to_return += second_half
          else
            while !first_half.empty? && cur_objs[0] < cur_objs[1]
              to_return << cur_objs[0]
              cur_objs[0] = first_half.shift
            end
            to_return += cur_objs.sort
            to_return += first_half
          end

          @sorted = to_return if arr.object_id == @original.object_id
          to_return
        end
      end

    end

  end

end