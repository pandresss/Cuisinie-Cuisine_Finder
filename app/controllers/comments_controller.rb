class CommentsController < ApplicationController
  def new
    # @comment = Comment.new
    # @comment.restaurant_id = Restaurant.show.id
  end

  def create
    p
    @comment = Comment.new(comment_params)
    p@comment
    if @comment.save
      redirect_to :back
    else
      # render({ comment: @comment.stream_id })
      redirect_to :back
      # render :new
    end
end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def comment_params
    params.require(:comment).permit(:author, :content, :user_id, :restaurant_id)
    end
end
