require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.current_user' do
    it 'creates a new user if the user with foo is not present' do
      expect(User.count).to eq 0
      expect{ User.current_user }.to change{ User.count }.from(0).to(1)
      expect(User.last.name).to eq 'foo'
    end

    it 'finds the user if the User is already present' do
      User.create(name: 'foo')
      expect(User.current_user.name).to eq 'foo'
    end
  end
end
