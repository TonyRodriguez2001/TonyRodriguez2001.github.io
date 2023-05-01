class AddEncryptedSubjectToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :encrypted_subject, :string
  end
end
