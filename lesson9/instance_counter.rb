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
