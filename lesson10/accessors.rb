module Accessors
  def attr_accessor_with_history(*args)
    args.each do |val_name|
      define_method("#{val_name}_history") do
        instance_eval("@#{val_name}_history ||= []")
      end
      define_method(val_name) do
        instance_variable_get("@#{val_name}")
      end
      define_method("#{val_name}=") do |value|
        instance_eval("#{val_name}_history << value")
        instance_variable_set("@#{val_name}", value)
      end
    end
  end

  def strong_attr_accessor(*args)
    args.each do |val_name|
      define_method(val_name) do
        instance_variable_get("@#{val_name}")
      end
      define_method("#{val_name}=") do |values|
        values = *values.compact
        raise ArgumentError, "Несоответствие параметров" unless values.size != 2
        raise ArgumentError, "Несоответствие типов" unless values.first.is_a?(values.last) 
        instance_variable_set("@#{val_name}", values.first)
      end
    end
  end
end