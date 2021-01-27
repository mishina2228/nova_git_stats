require 'spec_helper'

describe Symbol do
  describe '#t' do
    before do
      I18n.locale = :en
    end

    it 'translates itself' do
      expect(:project_name.t).to eq 'Project name'
    end
  end
end
