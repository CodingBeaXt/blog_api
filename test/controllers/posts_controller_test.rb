require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one) # assuming you have a post fixture
  end

  test "should get index" do
    get posts_url
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should create post with valid attributes" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: 'New Post', content: 'Some content' } }, headers: { 'Authorization' => "Token #{@user.auth_token}" }
    end
    assert_response :created
  end

  test "should not create post without authorization" do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { title: 'New Post', content: 'Some content' } }
    end
    assert_response :unauthorized
  end

  test "should not create post with invalid attributes" do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { title: '', content: '' } }, headers: { 'Authorization' => "Token #{@user.auth_token}" }
    end
    assert_response :unprocessable_entity
  end

  test "should return all posts on index" do
    get posts_url
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal Post.count, json_response.length
  end

  test "should show an error for non-existent post" do
    get post_url(id: 'non-existent-id')
    assert_response :not_found
    json_response = JSON.parse(@response.body)
    assert_equal 'Post not found', json_response['error']
  end
end
