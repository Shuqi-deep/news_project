require "test_helper"

class ArticlesRoutesTest < ActionDispatch::IntegrationTest
  test "should route to articles index" do
    assert_routing '/', controller: "articles", action: "index"
  end

  test "should route to article show" do
    assert_routing '/articles/1', controller: "articles", action: "show", id: "1"
  end

  test "should route to new article" do
    assert_routing '/articles/new', controller: "articles", action: "new"
  end

  test "should route to create article" do
    assert_routing({ method: 'post', path: '/articles' }, { controller: "articles", action: "create" })
  end

  test "should route to edit article" do
    assert_routing '/articles/1/edit', controller: "articles", action: "edit", id: "1"
  end

  test "should route to update article" do
    assert_routing({ method: 'patch', path: '/articles/1' }, { controller: "articles", action: "update", id: "1" })
    assert_routing({ method: 'put', path: '/articles/1' }, { controller: "articles", action: "update", id: "1" })
  end

  test "should route to destroy article" do
    assert_routing({ method: 'delete', path: '/articles/1' }, { controller: "articles", action: "destroy", id: "1" })
  end

  test "should route to article's comments create" do
    assert_routing({ method: 'post', path: '/articles/1/comments' }, { controller: "comments", action: "create", article_id: "1" })
  end

  test "should route to article's comments destroy" do
    assert_routing({ method: 'delete', path: '/articles/1/comments/1' }, { controller: "comments", action: "destroy", article_id: "1", id: "1" })
  end
end