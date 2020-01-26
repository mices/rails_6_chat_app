require "test_helper"

describe ChatsController do
  it "must get index" do
    get chats_index_url
    must_respond_with :success
  end

  it "must get show" do
    get chats_show_url
    must_respond_with :success
  end

end
