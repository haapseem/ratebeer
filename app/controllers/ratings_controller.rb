class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @topbeers = Beer.all.sort_by(&:average_rating).reverse.first(3)
    @topstyles = Style.all.sort_by(&:average_rating).reverse.first(3)
    @topbreweries = Brewery.all.sort_by(&:average_rating).reverse.first(3)
    @mostActiveUsers = User.all.sort_by { |u| u.ratings.count }.reverse.first(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user

    redirect_to user_path(current_user)
  end
end
