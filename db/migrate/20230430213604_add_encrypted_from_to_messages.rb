class AddEncryptedFromToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :encrypted_from, :string
  end
end
