# frozen_string_literal: true

# bier
class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, length: { minimum: 1 }

  def to_s
    name + ', ' + brewery.name
  end
end
