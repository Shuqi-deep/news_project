require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @article = articles(:one)
    @comment = comments(:one)
    sign_in @user
  end

  test "should create comment with valid content" do
    assert_difference('Comment.count', 1) do
      post article_comments_path(@article), params: { comment: { content: 'This is a valid comment.' } }
    end
    assert_redirected_to article_path(@article)
    assert_equal 'Комментарий добавлен.', flash[:notice]
  end

  test "should not create comment with invalid content" do
    assert_no_difference('Comment.count') do
      post article_comments_path(@article), params: { comment: { content: '' } }
    end
    assert_redirected_to article_path(@article)
    assert_equal 'Ошибка при добавлении комментария.', flash[:alert]
  end

  test "should destroy comment" do
    @comment = comments(:one)  # assuming this is a valid comment
    assert_difference('Comment.count', -1) do
      delete article_comment_path(@article, @comment)
    end
    assert_redirected_to article_path(@article)
    assert_equal 'Комментарий удален.', flash[:notice]
  end

  test "should not destroy comment if not logged in" do
    sign_out @user
    assert_no_difference('Comment.count') do
      delete article_comment_url(@article, @comment)
    end

    assert_redirected_to new_user_session_url
  end
end
