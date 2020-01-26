require "application_system_test_case"

describe "Messages", :system do
  let(:message) { messages(:one) }

  it "visiting the index" do
    visit messages_url
    assert_selector "h1", text: "Messages"
  end

  it "creating a Message" do
    visit messages_url
    click_on "New Message"

    fill_in "Content", with: @message.content
    fill_in "Recipients", with: @message.recipients
    fill_in "Sender", with: @message.sender
    click_on "Create Message"

    assert_text "Message was successfully created"
    click_on "Back"
  end

  it "updating a Message" do
    visit messages_url
    click_on "Edit", match: :first

    fill_in "Content", with: @message.content
    fill_in "Recipients", with: @message.recipients
    fill_in "Sender", with: @message.sender
    click_on "Update Message"

    assert_text "Message was successfully updated"
    click_on "Back"
  end

  it "destroying a Message" do
    visit messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Message was successfully destroyed"
  end
end
