require 'active_support/core_ext/string'

module Decorator

  module Inner
    def undecorate
      tech_instance = self.class.superclass.allocate
      self.instance_variables.each do |var|
        tech_instance.instance_variable_set(var, self.instance_variable_get(var))
      end
      tech_instance
    end

    def method_missing full_method_name, *args, &block
      if /(?<method_name>.*)_undecorated/ =~ full_method_name
        self.class.superclass.instance_method(method_name).bind(self).call(*args)
      end
    end
  end

  def Decorator.const_missing inner_name
    if /^(?<class_name>.*)_WITH_(?<decorator_name>.*)$/ =~ inner_name
      origin_class = class_name.constantize

      inner_class = Class.new(origin_class) do
        include decorator_name.constantize
        include Inner

        def initialize *args
          super if args.present?
        end
      end

      const_set inner_name, inner_class
    end
  end

end

class Object
  def decorate mod
    tech_instance = "Decorator::#{self.class.name}_WITH_#{mod.name}".constantize.new

    self.instance_variables.each do |var|
      tech_instance.instance_variable_set(var, self.instance_variable_get(var))
    end

    tech_instance.extend(mod)

    tech_instance
  end
end

class Class
  def decorate mod
    "Decorator::#{self.name}_WITH_#{mod.name}".constantize
  end
end