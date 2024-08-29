class CommentsController < ApplicationController
  before_action :authenticate_user! # Devise: требует, чтобы пользователь был аутентифицирован

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article), notice: 'Комментарий добавлен.'
    else
      redirect_to article_path(@article), alert: 'Ошибка при добавлении комментария.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@comment.article), notice: 'Комментарий удален.'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
