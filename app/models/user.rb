class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3 }

  validates :password, length: { minimum: 4 },
                       format: {
                         with: /[A-Z].*\d|\d.*[A-Z]/,
                         message: 'must contain one capital letter and number'
                       }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end

  def favorite_style
    return nil if ratings.empty?

    style_ratings = ratings.group_by { |r| r.beer.style }
    averages = style_ratings.map do |style, ratings|
      { style: style, score: average_of(ratings) }
    end

    averages.max_by { |r| r[:score] }[:style]
  end

  def favorite_brewery
    return nil if ratings.empty?

    style_ratings = ratings.group_by { |r| r.beer.brewery }
    averages = style_ratings.map do |brewery, ratings|
      { brewery: brewery, score: average_of(ratings) }
    end

    averages.max_by { |r| r[:score] }[:brewery]
  end

  def toggle_closed
    user = User.find(params[:id])
    user.update_attribute :closed, !user.closed

    new_status = user.frozen? ? 'closed' : 'opened'

    redirect_to user, notice: "account of #{user.username} #{new_status}"
  end
end
