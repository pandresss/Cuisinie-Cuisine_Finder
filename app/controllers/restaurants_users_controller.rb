class RestaurantsUsersController < ApplicationController
    def destroy
       @selected_row = RestaurantsUser.where(user_id: "#{current_user.id}"  , restaurant_id: params[:id] )
      p  row_id  = @selected_row[0].id
         if @selected_row.destroy(row_id)
           redirect_to user_path(current_user.id)
         else
           
         end
  end
end
