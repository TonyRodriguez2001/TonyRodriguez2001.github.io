class AddEncryptedBodyToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :encrypted_body, :text
  end
end
