class User < ApplicationRecord
  include Discard::Model

  validates :email, uniqueness: true, presence: true
end
