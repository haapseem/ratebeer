class User < ApplicationRecord
  include RatingAverage

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: {
                         with: /[A-Z].*\d|\d.*[A-Z]/,
                         message: "must contain one capital letter and number"
                       }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(:score).last.beer
  end
end
