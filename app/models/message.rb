class Message < ApplicationRecord

  include ::ActionView::Helpers::TextHelper
  has_rich_text :content
    acts_as_taggable

end
