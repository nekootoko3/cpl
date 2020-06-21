class PriorityQueue
  HEAP_TYPES = [:min, :max].freeze

  attr_accessor :heap
  attr_reader :heap_type

  # @param array [Array<Array<Integer, Any>|Integer>]
  # @param heap_type [Symbol]
  def initialize(array = nil, heap_type: :min)
    raise ArgumentError, "heap type is invalid: #{heap_type}" unless HEAP_TYPES.include?(heap_type)
    raise ArgumentError, "array is invalid: #{array}" unless valid_array?(array)

    @heap = build_array(array)
    @heap_type = heap_type

    build_heap! unless heap.empty?
  end

  # @param value [Integer | Array<Integer, Any>]
  def push(value)
    v = value.is_a?(Array) ? value : [value]
    heap << v

    current = heap.size - 1
    parent = (current - 1) / 2
    while parent >= 0
      break if heap_type == :min && heap[parent][0] < heap[current][0]
      break if heap_type == :max && heap[parent][0] > heap[current][0]

      heap[current], heap[parent] = heap[parent], heap[current]
      parent, current = (current - 1) / 2, parent
    end
  end

  # @return [Integer | Array<Integer, Any>]
  def pop
    return if heap.empty?

    res = heap.shift

    unless heap.empty?
      heap.unshift(heap.pop)
      heapify!(0) unless heap.empty?
    end

    res.size == 1 ? res[0] : res
  end

  def length
    heap.size
  end
  alias size length

  def empty?
    heap.empty?
  end

  private

  def build_heap!
    (heap.size/2).downto(0) { |i| heapify!(i) }
  end

  def heapify!(current)
    heap_type == :min ? min_heapify!(current) : max_heapify!(current)
  end

  def min_heapify!(current)
    left = current*2+1
    right = current*2+2
    smallest_value = [heap[current][0], heap[left]&.fetch(0, nil), heap[right]&.fetch(0, nil)].compact.min

    return if smallest_value == heap[current][0]

    swap_idx = smallest_value == heap[left][0] ? left : right
    heap[swap_idx], heap[current] = heap[current], heap[swap_idx]
    min_heapify!(swap_idx)
  end

  def max_heapify!(current)
    left = current*2+1
    right = current*2+2
    largest_value = [heap[current][0], heap[left]&.fetch(0, nil), heap[right]&.fetch(0, nil)].compact.max

    return if largest_value == heap[current][0]

    swap_idx = largest_value == heap[left][0] ? left : right
    heap[swap_idx], heap[current] = heap[current], heap[swap_idx]
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
