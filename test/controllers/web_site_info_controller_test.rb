require "test_helper"

class WebSiteInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_site_info_index_url
    assert_response :success
  end

  test "should get new" do
    get web_site_info_new_url
    assert_response :success
  end

  test "should get create" do
    get web_site_info_create_url
    assert_response :success
  end
end
