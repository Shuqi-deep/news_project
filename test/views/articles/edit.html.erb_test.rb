require "test_helper"

class ArticlesEditTest < ActionView::TestCase
  test "edit page displays correctly" do
    @article = Article.new(id: 1, title: "Sample Article", body: "This is a sample article.")
    render partial: "articles/form", locals: { article: @article }

    # Визуализируем шаблон edit
    render template: "articles/edit", locals: { article: @article }

    # Проверяем, что заголовок отображается правильно
    assert_select "h1", "Edit Article"

    # Проверяем, что форма редактирования рендерится
    assert_select "form" do
      assert_select "input[name='article[title]'][value=?]", @article.title
      assert_select "textarea[name='article[body]']", @article.body
    end

    # Проверяем наличие ссылки "Back"
    assert_select "a[href=?]", article_path(@article), text: "Back"
  end
end