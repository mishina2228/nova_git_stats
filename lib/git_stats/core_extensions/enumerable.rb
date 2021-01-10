module Enumerable
  def first!(&block)
    matching = find(&block)
    raise "Sequence contains no matching elements" if matching.nil?

    matching
  end
end
