class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.new
    @restaurant = User.all
    @cuisines_New = Cuisine.new
  end

  def show
    @new_restaurant = create
    @comment = Comment.new
    @comments = Comment.where(restaurant_id: @new_restaurant.id)
              end

  def create
    # p @restaurant_hash
    #   @restaurant = Restaurant.new(@restaurant_hash)
    #   if @restaurant.save
    #     p @restaurant.id
    #       @id = @restaurant.id
    #       else
    #     p "not saved"
    #    end
    p @restaurant = search.parsed_response
    p @restaurant_hash = { 'name' => @restaurant['name'],
                           'address' => @restaurant['location']['address'],
                           'img_url' => @restaurant['featured_image'],
                           'cost' => @restaurant['average_cost_for_two'],
                           'menu' => @restaurant['menu_url'],
                           'lat' => @restaurant['location']['latitude'],
                           'lon' => @restaurant['location']['longitude'],
                           'restaurant_id' => @restaurant['id'],
                           'user_rating' => @restaurant['user_rating']['aggregate_rating'] }
    Restaurant.find_or_create_by(@restaurant_hash)
  end

  # def destroy
  #   @restaurant = Restaurant.find(params[:id])
  #   if @restaurant.delete
  #     redirect_to user_path(current_user)
  #   else
  #     flash[:alert] = 'Nope you fucked up.'
  #   end
  # end

  private

  # def favorite_params
  #   params.require :restaurant.permit(:name, :address, :img_url, :user_rating)
  # end

  def search
    query = {
      'res_id' => params[:id]
    }
    @search = HTTParty.get('https://developers.zomato.com/api/v2.1/restaurant?', query: query, headers: headers)
  end

  def headers
    header = {
      'user-key' => 'c6dc40392af08897eafe323966c8dcf1'
    }
  end
end
