module SortingHat
  class Sorter
    module HeapSorter
      def heap_sort
        @sorted = []
        build_min_heap

        ((@original.length-1).downto(0)).each do |i|
          @heap.swap_values(0, i)
          @sorted<<(@heap.pop)
          if i>1
            min_heapify(0)
          end
        end
      end

      def max_heap_sort
        @sorted = []
        build_max_heap

        ((@original.length-1).downto(0)).each do |i|
          @heap.swap_values(0, i)
          @sorted.unshift(@heap.pop)
          max_heapify(0)
        end
      end

      private

      def build_max_heap
        @heap = Heap.new(@original)
        last_parent = @heap.last_parent
        (last_parent.downto(0)).each do |i|
          max_heapify(i)
        end
      end

      def build_min_heap
        @heap = Heap.new(@original)
        last_parent = @heap.last_parent
        (last_parent.downto(0)).each do |i|
          min_heapify(i)
        end
      end

      def max_heapify(current_index)
        largest = @heap.index_of_largest(current_index)
        if !(largest  == current_index)
          @heap.swap_values(current_index, largest)
          max_heapify(largest)
        end
      end

      def min_heapify(current_index)
        smallest = @heap.index_of_smallest(current_index)
        if !(smallest  == current_index)
          @heap.swap_values(current_index, smallest)
          min_heapify(smallest)
        end
      end

      class Heap

        attr_accessor :array_form
        private :array_form
        private :array_form=

        def initialize(orig)
          @array_form = orig.dup
        end

        def length
          array_form.length
        end

        def last_parent
          (length/2)-1
        end

        def pop
          array_form.pop
        end

        def value_at(i)
          array_form[i]
        end
        def index_of_parent(i)
          ((i/2).ceil)-1
        end
        def index_of_left(i)
          (i*2)+1
        end
        def index_of_right(i)
          (i+1)*2
        end

        def value_of_left(i)
          index = index_of_left(i)
          value_at(index)
        end
        def value_of_right(i)
          index = index_of_right(i)
          value_at(index)
        end

        def left_greater?(i)
          (value_of_left(i)) && (value_of_left(i) > value_at(i))
        end

        def right_greater?(i)
          (value_of_right(i)) && (value_of_right(i) > value_at(i))
        end

        def left_greater_than_right?(i)
          (value_of_left(i)) && ( !(value_of_right(i)) || (value_of_left(i) > value_of_right(i)))
        end

        def left_smaller?(i)
          (value_of_left(i)) && (value_of_left(i) < value_at(i))
        end

        def right_smaller?(i)
          (value_of_right(i)) && (value_of_right(i) < value_at(i))
        end

        def left_smaller_than_right?(i)
          (value_of_left(i)) && ( !(value_of_right(i)) || (value_of_left(i) < value_of_right(i)))
        end

        def index_of_largest(i)
          if (left_greater?(i)) && (left_greater_than_right?(i))
            index = index_of_left(i)
          elsif (right_greater?(i)) && !(left_greater_than_right?(i))
            index = index_of_right(i)
          else
            index = i
          end
          index
        end

        def index_of_smallest(i)
          if (left_smaller?(i)) && (left_smaller_than_right?(i))
            index = index_of_left(i)
          elsif (right_smaller?(i)) && !(left_smaller_than_right?(i))
            index = index_of_right(i)
          else
            index = i
          end
          index
        end

        def swap_values(i,j)
          temp = value_at(i)
          array_form[i] = value_at(j)
          array_form[j] = temp
        end
      
      end

    end
  end
end