require "test_helper"

class DevicesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get devices_create_url
    assert_response :success
  end

  test "should get update" do
    get devices_update_url
    assert_response :success
  end

  test "should get destroy" do
    get devices_destroy_url
    assert_response :success
  end
end
