class CommentsController < ApplicationController
  before_action :set_article


  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment has been added'
    else
      flash[:danger] = 'Error while adding comment. Please try again.'
    end

    redirect_to article_path(@article)
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
