# frozen_string_literal: true

# User class just dealing with a single current user
class User < ApplicationRecord
  def self.current_user
    find_or_create_by(name: 'foo')
  end
end
