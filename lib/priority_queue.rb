class PriorityQueue
  HEAP_TYPES = %i[min max].freeze

  # @param array [Array<Array<Integer, Any>|Integer>]
  # @param heap_type [Symbol]
  def initialize(array = nil, heap_type: :min)
    raise ArgumentError, "heap type is invalid: #{heap_type}" unless HEAP_TYPES.include?(heap_type)
    raise ArgumentError, "array is invalid: #{array}" unless valid_array?(array)

    @array = build_array(array)
    @heap_type = heap_type

    build_heap! unless @array.empty?
  end

  # @param value [Integer | Array<Integer, Any>]
  def push(value)
    v = value.is_a?(Array) ? value : [value]
    @array << v

    current = @array.size - 1
    parent = (current - 1) / 2
    while parent >= 0
      break if @heap_type == :min && @array[parent][0] < @array[current][0]
      break if @heap_type == :max && @array[parent][0] > @array[current][0]

      @array[current], @array[parent] = @array[parent], @array[current]
      parent, current = (current - 1) / 2, parent
    end
  end

  # @return [Integer | Array<Integer, Any>]
  def pop
    return if @array.empty?

    res = @array.shift

    unless @array.empty?
      @array.unshift(@array.pop)
      heapify!(0) unless @array.empty?
    end

    res.size == 1 ? res[0] : res
  end

  def length
    @array.size
  end
  alias size length

  def empty?
    @array.empty?
  end

  private

  def build_heap!
    (@array.size/2).downto(0) { |i| heapify!(i) }
  end

  def heapify!(current)
    @heap_type == :min ? min_heapify!(current) : max_heapify!(current)
  end

  def min_heapify!(current)
    left = current*2+1
    right = current*2+2
    smallest_value = [@array[current][0], @array[left]&.fetch(0, nil), @array[right]&.fetch(0, nil)].compact.min

    return if smallest_value == @array[current][0]

    swap_idx = smallest_value == @array[left][0] ? left : right
    @array[swap_idx], @array[current] = @array[current], @array[swap_idx]
    min_heapify!(swap_idx)
  end

  def max_heapify!(current)
    left = current*2+1
    right = current*2+2
    largest_value = [@array[current][0], @array[left]&.fetch(0, nil), @array[right]&.fetch(0, nil)].compact.max

    return if largest_value == @array[current][0]

    swap_idx = largest_value == @array[left][0] ? left : right
    @array[swap_idx], @array[current] = @array[current], @array[swap_idx]
    max_heapify!(swap_idx)
  end

  def valid_array?(array)
    return true if array.nil?
    return false unless array.is_a?(Array)

    array.all? { |el| el.is_a?(Array) && el[0].is_a?(Integer) } ||
      array.all? { |el| el.is_a?(Integer) }
  end

  def build_array(array)
    case array
    when nil; []
    when proc { |arr| arr.all? { |el| el.is_a?(Array) } }; array
    else; array.map { |el| [el] }
    end
  end
end
