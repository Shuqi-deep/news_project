require "test_helper"

class ArticlesShowTest < ActionView::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one) # Предполагается, что в фикстурах есть пользователь с ID один
    @article = articles(:one) # Используем фикстуру статьи
    sign_in @user
  end

  test "show page displays correctly" do
    # Визуализируем шаблон show с фикстурой статьи
    render template: "articles/show", locals: { article: @article }

    # Проверяем наличие заголовка статьи
    assert_select "h1", text: @article.title

    # Проверяем наличие кнопки "Back"
    assert_select "a[href=?]", articles_path do
      assert_select "img[src=?]", "/back.svg"
      assert_select "a", text: "Back"
    end

    # Проверяем кнопки "Edit" и "Destroy", если текущий пользователь - автор статьи
    if @article.user == @user
      assert_select "a[href=?]", edit_article_path(@article) do
        assert_select "img[src=?]", "/pen-square.svg"
        assert_select "a", text: "Edit"
      end

      assert_select "form[action=?][method=?]", article_path(@article), "post" do
        assert_select "input[type=hidden][name=_method][value=delete]"
        assert_select "button[data-confirm=?]", "Вы уверены?" do
          assert_select "img[src=?]", "/delete-2.svg"
          assert_select "button", text: "Destroy"
        end
      end
    end

    # Проверка даты публикации статьи
    assert_select "p", text: /Published at: \d{2}\.\d{2}\.\d{4}/

    # Проверка отображения изображения статьи, если оно прикреплено
    if @article.photo.attached?
      assert_select "img[src=?]", rails_blob_path(@article.photo, only_path: true)
    end

    # Проверка тела статьи
    assert_select "p", text: @article.body

    # Проверка отображения автора
    assert_select "span", text: "Author: #{@article.user.email}"

    # Проверка кнопок социальных сетей
    %w[vk wa ok tg].each do |social|
      assert_select "button[data-social=?]", social do
        assert_select "img"
      end
    end

    # Проверка кнопки для копирования ссылки
    assert_select "button[onclick=?]", "copyToClipboard()" do
      assert_select "img[src=?]", "/copy.svg"
    end

    # Проверка отображения комментариев
    assert_select "h3", text: "Сообщений: #{@article.comments.length-1}"

  end
end
