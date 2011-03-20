require 'test_helper'

class QrItemsControllerTest < ActionController::TestCase
  test "should get vcard" do
    get :vcard
    assert_response :success
  end

end
