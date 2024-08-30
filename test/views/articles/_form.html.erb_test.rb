require "test_helper"

class ArticlesFormTest < ActionView::TestCase
  test "form displays correctly" do
    @article = Article.new

    # Визуализируем частичную форму с объектом article
    render partial: "articles/form", locals: { article: @article }

    # Проверяем, что форма содержится на странице
    assert_select "form" do
      assert_select "label[for=article_title]", "Title"
      assert_select "input[name='article[title]']"
      assert_select "label[for=article_body]", "Body"
      assert_select "textarea[name='article[body]']"
      assert_select "label[for=article_photo]", "Photo"
      assert_select "input[name='article[photo]'][type=file]"
      assert_select "input[type=submit]"
    end
  end

  test "form displays error messages" do
    @article = Article.new
    @article.validate # вызывает валидацию, чтобы заполнить объект article ошибками

    render partial: "articles/form", locals: { article: @article }

    assert_select "div#error_explanation" do
      assert_select "h2", /prohibited this article from being saved/
      assert_select "ul" do
        assert_select "li", minimum: 1 # хотя бы одна ошибка должна быть показана
      end
    end
  end
end