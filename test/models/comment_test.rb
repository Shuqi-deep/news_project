require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @article = articles(:one)
    @comment = Comment.new(content: "This is a comment", article: @article, user: @user)
  end

  test "should be valid with valid attributes" do
    assert @comment.valid?
  end

  test "should be invalid without content" do
    @comment.content = nil
    assert_not @comment.valid?, "Comment is valid without content"
  end

  test "should be invalid without an article" do
    @comment.article = nil
    assert_not @comment.valid?, "Comment is valid without an article"
  end

  test "should be invalid without a user" do
    @comment.user = nil
    assert_not @comment.valid?, "Comment is valid without a user"
  end
end
