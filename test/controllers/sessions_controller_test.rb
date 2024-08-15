require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should login with valid credentials" do
    post login_url, params: { email: @user.email, password: 'password123' }
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response['auth_token']
  end

  test "should not login with invalid credentials" do
    post login_url, params: { email: @user.email, password: 'wrongpassword' }
    assert_response :unauthorized
    json_response = JSON.parse(@response.body)
    assert_equal 'Invalid email or password', json_response['error']
  end

  test "should logout successfully when authenticated" do
    delete logout_url, headers: { 'Authorization' => "Token #{@user.auth_token}" }
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal 'Logged out successfully', json_response['message']
  end

  test "should not logout without authorization" do
    delete logout_url
    assert_response :unauthorized
    json_response = JSON.parse(@response.body)
    assert_equal 'Unauthorized', json_response['error']
  end
end
