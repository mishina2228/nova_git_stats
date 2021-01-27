class Hash
  def to_key_indexed_array(min_size: 0, default: nil)
    unless all? { |k, _v| k.is_a? Numeric }
      raise ArgumentError, 'all the keys must be numbers to convert to key indexed array'
    end

    each_with_object(Array.new(min_size, default)) { |(k, v), acc| acc[k] = v }.map { |e| e || default }
  end

  def fill_empty_days!(aggregated: true)
    return self if empty?

    self_with_date_keys = transform_keys(&:to_date)
    days_with_data = self_with_date_keys.keys.sort.uniq
    prev = 0

    days_with_data.first.upto(days_with_data.last) do |day|
      if days_with_data.include?(day)
        prev = self_with_date_keys[day]
      else
        self[day] = aggregated ? prev : 0
      end
    end
    self
  end
end
