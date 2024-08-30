require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)  # Загружаем фикстуру пользователя
    @article = @user.articles.build(title: "Test Title", body: "Test Body")
  end

  test "should belong to a user" do
    assert_equal @user, @article.user
  end

  test "should have many comments" do
    assert_respond_to @article, :comments
  end

  test "should destroy associated comments" do
    @article.save
    @article.comments.create!(content: "Test Comment", user: @user)
    assert_difference('Comment.count', -1) do
      @article.destroy
    end
  end

  test "should be valid with valid attributes" do
    user = User.create!(email: "unique_test_user@example.com", password: "password")
    article = user.articles.build(title: "Valid Title", body: "Valid Body")
    assert article.valid?
  end

  test "should not be valid without a title" do
    @article.title = ""
    assert_not @article.valid?, "Article is valid without a title"
    assert_includes @article.errors[:title], "can't be blank"
  end

  test "should not be valid without a body" do
    @article.body = ""
    assert_not @article.valid?, "Article is valid without a body"
    assert_includes @article.errors[:body], "can't be blank"
  end

  test "should accept valid photo" do
    @article.photo.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'valid_image.jpg')), filename: 'valid_image.jpg', content_type: 'image/jpeg')
    assert @article.valid?
  end

  test "should reject photo with invalid content type" do
    @article.photo.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'invalid_image.txt')), filename: 'invalid_image.txt', content_type: 'text/plain')
    assert_not @article.valid?, "Article is valid with an invalid photo content type"
    assert_includes @article.errors[:photo], "must be a JPEG or PNG"
  end

  test "should reject photo with size greater than 5MB" do
    @article.photo.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'large_image.jpg')), filename: 'large_image.jpg', content_type: 'image/jpeg')
    assert_not @article.valid?, "Article is valid with a photo larger than 5MB"
    assert_includes @article.errors[:photo], "size should be less than 5MB"
  end
end
