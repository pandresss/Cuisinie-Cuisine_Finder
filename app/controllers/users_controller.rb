class UsersController < ApplicationController
  def index
    @newUser_Restaurant = User.all
  end

  def show
    @newUser_Restaurant = User.find(current_user.id)
    @restaurants = Restaurant.includes(:users).where("users.id=#{current_user.id}").references(:users)
    # @user =
  end

#   def destroy
#
#     p @rest_user = RestaurantsUser.where(user_params)
#     p @rest_user
#
#
#     p @use = User.find(@id[:user_id])
#     p @rest = Restaurant.find(@id[:restaurant_id])
#     p "============================"
#     p @use.restaurants
#     @restaurant = Restaurant.where(:user_id => params[:id])
#     if @restaurant.delete
#       redirect_to user_path
#     else
#       redirect_to :back
#     end
# end

private


def user_params
  @id = params.require(:users).permit(:restaurant_id, :user_id)
end

end
