require "test_helper"

class CommentsPartialTest < ActionView::TestCase
  include Devise::Test::ControllerHelpers
  include Rails.application.routes.url_helpers

  def setup
    @user = users(:one) # Используем фикстуру пользователя
    @article = articles(:one) # Используем фикстуру статьи
    @comment = @article.comments.create!(content: "This is a test comment", user: @user)
    
    # Имитируем текущего пользователя
    @view_context = ActionController::Base.new.view_context
    @view_context.singleton_class.send(:define_method, :current_user) { @user }
  end

  test "comment displays correctly" do
    # Визуализируем частичный шаблон комментария
    render partial: "comments/comment", locals: { comment: @comment }

    # Проверка отображения имени пользователя и даты комментария
    assert_select "strong", text: @comment.user.email
    assert_select "div.title", text: /#{@comment.created_at.strftime('%d.%m.%y, %H:%M')}/

    # Проверка отображения контента комментария
    assert_select "div.body", text: @comment.content
  end

  test "comment does not show delete button for other users" do
    other_user = users(:two) # Используем фикстуру другого пользователя

    # Имитируем текущего пользователя как другого пользователя
    @view_context.singleton_class.send(:define_method, :current_user) { other_user }

    # Визуализируем частичный шаблон комментария
    render partial: "comments/comment", locals: { comment: @comment }

    # Проверка, что кнопка удаления отсутствует для другого пользователя
    assert_select "form[action=?]", article_comment_path(@article, @comment), count: 0
  end
end