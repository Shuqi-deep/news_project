require "test_helper"

class ArticlesIndexTest < ActionView::TestCase
  def setup
    @articles = Article.all
  end

  test "index page displays correctly" do
    # Визуализируем шаблон index с фикстурами статей
    render template: "articles/index", locals: { articles: @articles }

    # Проверяем, что заголовок отображается правильно
    assert_select "h1", text: "Articles"

    # Проверяем, что ссылка на создание новой статьи отображается правильно
    assert_select "a[href=?]", new_article_path, text: "New Article"

    # Проверяем отображение всех статей
    @articles.each do |article|
      assert_select "a[href=?]", article_path(article) do
        # Проверяем, что отображается заголовок статьи
        assert_select "p", text: article.title

        # Проверяем отображение даты создания статьи
        assert_select "p.text-gray-400", text: article.created_at.strftime("%d %B")

        # Проверяем отображение изображения статьи (или изображения по умолчанию, если фото не прикреплено)
        if article.photo.attached?
          assert_select "img[src=?]", rails_blob_path(article.photo, only_path: true)
        else
          assert_select "img[src=?]", "/erus.jpg"
        end
      end
    end
  end
end