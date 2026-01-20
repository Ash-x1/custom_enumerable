module Enumerable
  # Your code goes here
  def my_enum
    result = []
    my_each do |array|
      result << yield(array) 
    end
    result
  end
  
  def my_all?
    result = true

    my_each do |value|
      unless yield(value)
        result = false
        break
      end
    end

    result
  end

  def my_any?
    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    count = 0

    if block_given?
      my_each do |value|
        count += 1 if yield(value)
      end
    else
      my_each { |_| count += 1 }
    end

    count
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end

    self
  end

  def my_inject(initial)
    accum = initial

    my_each do |element|
      accum = yield(accum, element)
    end

    accum
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end
end
