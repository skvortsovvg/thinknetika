module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate(var_name, validation_type, option = nil)
    validations[validation_type].call(var_name, option)
  end

  def validations
    { 
      type: lambda { |var_name, option| raise ArgumentError, "Несоответствие типов: реквизит #{var_name} должен иметь тип #{option}" unless instance_eval("@#{var_name}.is_a?(option)") },
      presence: proc { |var_name| raise ArgumentError, "Не задано значение реквизита #{var_name}!" if instance_eval("@#{var_name}.nil? || @#{var_name}.to_s.empty?") },
      format: lambda { |var_name, option| raise ArgumentError, "Некорректный формат реквизита #{var_name}" if instance_eval("@#{var_name} !~ option") }
    }
  end
end