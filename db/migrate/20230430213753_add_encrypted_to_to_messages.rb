class AddEncryptedToToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :encrypted_to, :string
  end
end
