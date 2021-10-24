module GitStats
  module Inspector
    def to_s
      vars = ivars_to_be_displayed.map do |sym|
        var = instance_variable_get(sym)
        [sym, var.is_a?(String) ? %("#{var}") : var].join('=')
      end.join(', ')
      "#<#{self.class} #{vars}>"
    end

    def ivars_to_be_displayed
      instance_variables
    end

    def inspect
      to_s
    end
  end
end
