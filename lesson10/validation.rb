module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate(name, style, option = nil)
    case style
    when :type
      raise ArgumentError, "Несоответствие типов: реквизит #{name} должен иметь тип #{option}" unless instance_eval("@#{name}.is_a?(option)")
    when :presence
      raise ArgumentError, "Не задано значение реквизита #{name}!" if instance_eval("@#{name}.nil? || @#{name}.to_s.empty?")
    when :format
      raise ArgumentError, "Некорректный формат реквизита #{name}" if instance_eval("@#{name} !~ option")
    end
  end
end
