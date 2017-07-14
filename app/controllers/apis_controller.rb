class ApisController < ApplicationController
  def create
    @new_data = search.parsed_response
    @new_data['restaurants']
    @filtered_response = @new_data['restaurants'].map do |restaurant|
      { 'name' => restaurant['restaurant']['name'],
        'address' => restaurant['restaurant']['location']['address'],
        'img_url' => restaurant['restaurant']['featured_image'],
        'cost' => restaurant['restaurant']['average_cost_for_two'],
        'lat' => restaurant['restaurant']['location']['latitude'],
        'lon' => restaurant['restaurant']['location']['longitude'],
        'restaurant_id' => restaurant['restaurant']['id'],
        'user_rating' => restaurant['restaurant']['user_rating']['aggregate_rating'] }
    end
    render json: @filtered_response
  end

  def new
    params = favorite_params
    params[:user_id] = "#{current_user.id}"
    p @newUser_Restaurant = RestaurantsUser.new(params)
    if @newUser_Restaurant.save
      flash[:notice] = 'Restaurant saved successfully!'
      render json: {'id' => current_user.id}
    else
      flash[:alert] = "failed"
      redirect_back fallback_location: root_path
    end
  end

  # def destory
  #   if @newUser_Restaurant.destory
  #     redirect_to user_path(current_user.id)
  #   else
  #     redirect_to @newUser_Restaurant
  #   end
  # end

  private

  def search
    query = {
      'entity_id' => 280,
      'entity_type' => 'city',
      'cuisines' => cuisine_params['id']
    }
    @cuisine = HTTParty.get('https://developers.zomato.com/api/v2.1/search?', query: query, headers: headers)
  end

  def headers
    header = {
      'user-key' => 'c6dc40392af08897eafe323966c8dcf1'
    }
  end

  def cuisine_params
    id = params.require(:cuisine).permit(:id)
  end

  def favorite_params
    id = params.require(:restaurantsuser).permit(:user_id, :restaurant_id)
 end
end
