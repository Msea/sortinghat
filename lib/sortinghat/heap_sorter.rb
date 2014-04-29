module SortingHat
  class Sorter
    module HeapSorter
      def heap_sort
        @sorted = []
        build_heap

        ((@original.length-1).downto(0)).each do |i|
          @heap.swap_values(0, i)
          @sorted.unshift(@heap.pop) #refactor this
          heapify(0)
        end

      end

      #private

      def build_heap
        @heap = Heap.new(@original)
        last_parent = @heap.last_parent
        (last_parent.downto(0)).each do |i|
          heapify(i)
        end
      end

      def heapify(current_index)
        largest = @heap.index_of_largest(current_index)
        if !(largest  == current_index)
          @heap.swap_values(current_index, largest)
          heapify(largest)
        end
      end

      class Heap

        attr_accessor :tree_array
        private :tree_array
        private :tree_array=

        def initialize(tree)
          @tree_array = tree.dup
        end

        def length
          tree_array.length
        end

        def last_parent
          length/2
        end

        def pop
          tree_array.pop
        end

        def value_at(i)
          tree_array[i]
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

        def swap_values(i,j)
          temp = value_at(i)
          tree_array[i] = value_at(j)
          tree_array[j] = temp
        end
      
      end



    end
  end
end