require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should get index" do
    get post_comments_url(@post), headers: { 'Authorization' => "Token #{@user.auth_token}" }
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal @post.comments.count, json_response.length
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post post_comments_url(@post), params: { comment: { content: "Great post!" } }, headers: { 'Authorization' => "Token #{@user.auth_token}" }
    end
    assert_response :created
    json_response = JSON.parse(@response.body)
    assert_equal "Great post!", json_response['content']
  end

  test "should not create comment with without content" do
    assert_no_difference('Comment.count') do
      post post_comments_url(@post), params: { comment: { content: "" } }, headers: { 'Authorization' => "Token #{@user.auth_token}" }
    end
    assert_response :unprocessable_entity
    json_response = JSON.parse(@response.body)
    assert_includes json_response['content'], "can't be blank"
  end
end
