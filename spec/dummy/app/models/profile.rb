# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :author, inverse_of: :profile, touch: true

  enum status: { basic: 0, advanced: 1, premium: 2 }

  def to_s
    description
  end
end
