require 'rails_helper'

RSpec.describe Groups::ListGroups, type: :use_case do
  describe '#execute' do
    let!(:group1) { create(:group, name: 'Amigo Secreto') }
    let!(:group2) { create(:group, name: 'Familia') }

    it 'lists groups filtered by name' do
      result = described_class.new({ name: 'Amigo Secreto' }).execute
      expect(result[:status]).to eq(:ok)
      expect(result[:data]).to include(group1)
      expect(result[:data]).not_to include(group2)
    end

    it 'orders groups by name' do
      result = described_class.new({ order: 'name', direction: 'desc' }).execute
      expect(result[:status]).to eq(:ok)
      expect(result[:data].first).to eq(group2)
    end

    it 'paginates groups' do
      create_list(:group, 15)
      result = described_class.new({ page: 1, per_page: 4 }).execute
      expect(result[:status]).to eq(:ok)
      expect(result[:data].size).to eq(4)
    end

    it 'handles errors gracefully' do
      allow_any_instance_of(Groups::Builders::GroupQueryBuilder).to receive(:result).and_raise(StandardError, 'Something went wrong')
      result = described_class.new({}).execute
      expect(result[:status]).to eq(:internal_server_error)
      expect(result[:message]).to eq('Something went wrong')
    end
  end
end
