class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all.limit(16)
    @user = User.new
  end

  def search
    @hotels = Hotel.search_hotels(params[:search])
  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    user = User.find(@hotel.user_id)
    if user.owner?
      if @hotel.save
        flash[:succes] = "You add a hotel!"
        redirect_to hotel_path(@hotel)
      else
        flash.now[:error] = "#{@hotel.errors.messages}"
        render template: "hotels/new"
      end
    end
  end

  def edit
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    user = User.find(@hotel.user_id)
    if user.owner?
      if @hotel.update(hotel_params)
        flash[:succes] = "You edit hotel!"
        redirect_to hotel_path(@hotel)
      else
        flash.now[:error] = "#{@hotel.errors.messages}"
        render template: "hotels/edit"
      end
    end
  end

  private
  def hotel_params
    params.require(:hotel).permit(:user_id, :hotel_name, :description, :price, :country, :city, :rating)
  end
end
