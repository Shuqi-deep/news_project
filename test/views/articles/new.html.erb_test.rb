require "test_helper"

class ArticlesNewTest < ActionView::TestCase
  test "new page displays correctly" do
    @article = Article.new

    # Визуализируем шаблон new
    render template: "articles/new", locals: { article: @article }

    # Проверяем, что заголовок отображается правильно
    assert_select "h1", text: "New Article"

    # Проверяем, что форма для новой статьи рендерится
    assert_select "form" do
      assert_select "input[name='article[title]']"
      assert_select "textarea[name='article[body]']"
    end

    # Проверяем наличие кнопки "Back" с правильной ссылкой
    assert_select "a[href=?]", articles_path, text: "Back"
  end
end