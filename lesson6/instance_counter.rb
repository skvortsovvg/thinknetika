module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  
  module ClassMethods    
    @@instances = 0

    def instances
      @@instances
    end

    def increase
      @@instances += 1
    end

  end

  module InstanceMethods
    def register_instance
      self.class.increase
    end  
  end 
end
