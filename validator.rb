module Validator
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(validation_field, validation_type, validation_attr = '')
      validations << {
        field: validation_field,
        type: validation_type,
        attr: validation_attr
      }
    end

    def validation_presence(var_value, **validation)
      !(var_value.nil? || var_value == '')
    end

    def validation_type(var_value, **validation)
      var_value.instance_of? validation[:attr]
    end

    def validation_format(var_value, **validation)
      !(var_value !~ validation[:attr])
    end

    def validation_error(var_value, **validation)
      "Validation error for value '#{var_value}'\n
       field: #{validation[:field]}\n
       type: #{validation[:type]}\n
       attribute: #{validation[:attr]}"
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        var_value = instance_variable_get("@#{validation[:field]}")
        validation_method = "validation_#{validation[:type]}".to_sym

        valid = self.class.send(validation_method, var_value, validation)
        raise self.class.validation_error(var_value, validation) if !valid
      end
    end
  end
end
