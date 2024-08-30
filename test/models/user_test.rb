require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should be invalid without email" do
    @user.email = nil
    assert_not @user.valid?, "User is valid without an email"
  end

  test "should have unique email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?, "User is valid with a duplicate email"
  end

  test "should have many articles" do
    assert_respond_to @user, :articles
  end

  test "should have many comments" do
    assert_respond_to @user, :comments
  end

  test "associated comments should be destroyed when user is destroyed" do
    @user.save
    @user.comments.create!(content: "A comment", article: articles(:one))
    assert_difference 'Comment.count', -@user.comments.count do
      @user.destroy
    end
  end
end
