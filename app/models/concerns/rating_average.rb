# frozen_string_literal: true

# avg rating
module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.average(:score)
  end
end
