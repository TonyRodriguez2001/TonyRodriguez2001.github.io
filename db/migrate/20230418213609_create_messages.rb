class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
