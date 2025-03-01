require 'rails_helper'

RSpec.describe Groups::CreateGroup, type: :use_case do
  describe '#execute' do
    let(:params) { { name: 'Amigos Secreto' } }

    it 'creates a group' do
      group = described_class.new(params).execute
      expect(group).to be_persisted
    end
  end
end
