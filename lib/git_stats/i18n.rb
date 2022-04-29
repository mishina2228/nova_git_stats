# frozen_string_literal: true

I18n.load_path += Dir[GitStats.root.join('config/locales/*.yml')]
I18n.enforce_available_locales = true
