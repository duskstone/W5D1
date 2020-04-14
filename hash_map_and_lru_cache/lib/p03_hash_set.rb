require "byebug"
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    # debugger
    
    i = (key.hash % num_buckets)
    if !@store[i].include?(key)
        @store[i] << key
        @count += 1
    end 
  end

  def include?(key)
    @store.any? { |subarr| subarr.one?(key) }
  end

  def remove(key)
    i = (key.hash % num_buckets)
    if self.include?(key) 
      @store[i].delete(key)
      @count -= 1
    end 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count > @store.length 
      new_store = Array.new(@store.length * 2) {Array.new}
      @store.each do |subarr|
        subarr.each do |ele|
          bucket = ele.hash % new_store.length
          new_store[bucket] << ele 
        end 
      end 
      @store = new_store 
    end 
    @num_buckets = @store.length
    @num_buckets
  end
end
