# frozen_string_literal: true

class Symbol
  def t
    I18n.t self
  end
end
