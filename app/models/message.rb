class Message < ApplicationRecord

  include ::ActionView::Helpers::TextHelper
  has_rich_text :content

end
