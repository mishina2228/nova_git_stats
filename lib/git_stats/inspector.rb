module GitStats
  module Inspector
    def to_s
      vars = defined_ivars.map do |sym|
        value = if ivars_to_be_filtered.include?(sym)
                  '...'
                else
                  var = instance_variable_get(sym)
                  var.is_a?(String) ? %("#{var}") : var.inspect
                end
        [sym, value].join('=')
      end
      vars = vars.join(', ').presence
      "#<#{[self.class, vars].compact.join(' ')}>"
    end

    def inspect
      to_s
    end

    def pretty_print(pp)
      pp.object_address_group(self) do
        pp.seplist(defined_ivars, proc { pp.text(',') }) do |attr_name|
          pp.breakable(' ')
          pp.group(1) do
            pp.text(attr_name.to_s)
            pp.text('=')
            if ivars_to_be_filtered.include?(attr_name)
              pp.text('...')
            else
              pp.pp(instance_variable_get(attr_name))
            end
          end
        end
      end
    end

    private

    def ivars_to_be_displayed
      instance_variables
    end

    def ivars_to_be_filtered
      []
    end

    def defined_ivars
      (ivars_to_be_displayed | ivars_to_be_filtered).select { |sym| instance_variable_defined?(sym) }
    end
  end
end
