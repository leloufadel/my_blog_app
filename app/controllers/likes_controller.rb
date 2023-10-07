class LikesController < ApplicationController
    before_action :find_post, only: %i[create destroy]
  
    def create
      @like = current_user.likes.build(post: @post)
  
      if @like.save
        flash[:notice] = 'Post liked successfully.'
      else
        flash[:alert] = 'Failed to like the post.'
      end
  
      redirect_back(fallback_location: root_path)
    end
  
    def destroy
      @like = current_user.likes.find_by(post: @post)
  
      if @like
        @like.destroy
        flash[:notice] = 'Post unliked successfully.'
      else
        flash[:alert] = 'Like not found.'
      end
  
      redirect_back(fallback_location: root_path)
    end
  
    private
  
    def find_post
      @post = Post.find(params[:post_id])
    end
  end
  