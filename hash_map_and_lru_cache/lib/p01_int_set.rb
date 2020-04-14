require "byebug"
class MaxIntSet
  # attr_reader :max, :store
  attr_reader :store

  def initialize(max)
    # @max = max
    @store = Array.new(max, false)
  end

  # def insert(num)
  #   raise "Out of bounds" if (num + 1) > @max || num < 0
  #   (0..@max).each do |i|
  #     if (i + 1) == num 
  #       @store[i + 1] = true 
  #     end 
  #   end 
  #   @store.include?(num + 1)
  # end

  def insert(num)
    validate!(num)
    return false if @store[num] 
    self.store[num] = true
  end

  # def remove(num)
  #   @store[num] = false
  # end

  def remove(num)
    validate!(num)
    return nil unless include?(num)
    self.store[num] = false 
    num
  end

  def include?(num)
    validate!(num)
    self.store[num]
  end

  # def include?(num)
  #   # return false unless @store[num+1] == true
  #   @store[num]
  #   # if @store.index(num) == true 
  #   #   return true
  #   # end
  #   # false
  # end

  private

  def is_valid?(num)
    num.between?(0, self.store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num) #our bracket method not working, returning nil 
    i = (num % num_buckets)
    @store[i] << num if !@store.include?(num) 
  end

  def remove(num)
    @store[num].delete(num)
  end

  def include?(num)
    @store.any? { |subArr| subArr.one?(num) }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = (num % num_buckets)
    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  # attr_reader :count
  # attr_accessor :num_buckets
  attr_accessor :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # def insert(num)
  #   # debugger
  #   i = (num % num_buckets)
  #    if !@store[i].include?(num) 
  #         @store[i] << num
  #         @count += 1
  #   #  else 
  #   #     count += 15
  #   end
  #   @count
  # end

  def insert(num) 
    return false if include?(num)
    self[num] << num 
    self.count += 1
    resize! if num_buckets < self.count
    
    num
  end

  # def remove(num)
  #   if self.include?(num) 
  #     @store[num].delete(num)
  #     @count -= 1
  #   end 
  # end

  def remove(num)
    self.count -= 1 if self[num].delete(num)
  end 

  # def include?(num)
  #   @store.any? { |subArr| subArr.one?(num) }
  # end

    def include?(num)
      self[num].include?(num)
    end

  private

  def [](num)
    self.store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  # def num_buckets
  #   @store.length
  # end
  def num_buckets
    self.store.length
  end 
  #debugger
  # def resize!
  #   # debugger
  #   if @count > @store.length
  #      new_store = Array.new(@store.length * 2) {Array.new}
  #       # @num_buckets = @num_buckets * 2
  #       # count.times {new_store.insert(old_ele) 
  #     @store.each do |subarr|
  #     #  if !subarr.empty? 
  #          subarr.each do |ele| 
  #           bucket = (ele % new_store.length)
  #           new_store[bucket] << ele
  #          end
  #     #  end 
  #     end
  #       #  @num_buckets = new_store.length
  #         @store = new_store  
  #   end
  #  @num_buckets = @store.length
  #  @num_buckets
  # end

  def resize!
    old_store = self.store 
    self.count = 0 
    self.store = Array.new(num_buckets * 2) {Array.new}

    old_store.flatten.each { |num| insert(num)}
  end 
  
end
