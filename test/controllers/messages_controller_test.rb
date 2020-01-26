require "test_helper"

describe MessagesController do
  let(:message) { messages(:one) }

  it "should get index" do
    get messages_url
    must_respond_with :success
  end

  it "should get new" do
    get new_message_url
    must_respond_with :success
  end

  it "should create message" do
    assert_difference("Message.count") do
      post messages_url, params: { message: { content: @message.content, recipients: @message.recipients, sender: @message.sender } }
    end

    must_redirect_to message_url(Message.last)
  end

  it "should show message" do
    get message_url(@message)
    must_respond_with :success
  end

  it "should get edit" do
    get edit_message_url(@message)
    must_respond_with :success
  end

  it "should update message" do
    patch message_url(@message), params: { message: { content: @message.content, recipients: @message.recipients, sender: @message.sender } }
    must_redirect_to message_url(message)
  end

  it "should destroy message" do
    assert_difference("Message.count", -1) do
      delete message_url(@message)
    end

    must_redirect_to messages_url
  end
end
