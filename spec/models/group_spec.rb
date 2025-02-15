require 'rails_helper'

RSpec.describe Group, type: :model do
  it "is valid with a name" do
    group = Group.new(name: "Amigos Secreto")
    expect(group).to be_valid
  end

  it "is invalid without a name" do
    group = Group.new(name: nil)
    expect(group).to_not be_valid
  end
end
