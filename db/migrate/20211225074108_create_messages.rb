class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
