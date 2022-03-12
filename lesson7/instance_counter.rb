module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  
  module ClassMethods    
  
    def instances
      @instances ||= 0
    end
    
    def increase
      @instances = 0 if @instances.nil?
      @instances += 1
    end

  end

  module InstanceMethods
    def register_instance
      self.class.increase
    end  
  end 
end

# class A
#   class << self
#     attr_accessor :a
#   end
#   # Вместо этого такая строка: self.class.attr_accessor :a
#   # невозможна только потому, что attr_accessor это private method :(
# end

# class B < A
# end

# A.instance_variables # => ["@a"]
# A.class_variables    # => []
# puts A.a   # => nil

# A.a = 123
# puts A.a   # => 123

# puts B.a