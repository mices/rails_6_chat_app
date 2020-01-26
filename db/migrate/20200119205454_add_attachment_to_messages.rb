class AddAttachmentToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :attachment, :string
  end
end
