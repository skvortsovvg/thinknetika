module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
  
  module ClassMethods
    
    $VALIDATIONS =
    { 
      type: lambda { |var_name, value, option| raise ArgumentError, "Несоответствие типов: реквизит #{var_name} должен иметь тип #{option}" unless value.is_a?(option) },
      presence: proc { |var_name, value| raise ArgumentError, "Не задано значение реквизита #{var_name}!" if value.nil? || value.to_s.empty? },
      format: lambda { |var_name, value, option| raise ArgumentError, "Некорректный формат реквизита #{var_name}" if value !~ option }
    }

    def validate(var_name, validation_type, option = nil)
      validations << { var_name: var_name, validation_type: validation_type, option: option }
    end

    def validations
      @validations ||= []
    end

  end
end