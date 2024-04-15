require "test_helper"

class WebSiteInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_site_infos_index_url
    assert_response :success
  end

  test "should get new" do
    get web_site_infos_new_url
    assert_response :success
  end

  test "should get create" do
    get web_site_infos_create_url
    assert_response :success
  end
end
