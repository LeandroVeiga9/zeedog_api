class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :internal_name, null: false
      t.string :external_name, null: false
      t.string :description, null: false
      t.string :manufacturer, null: false
      t.boolean :active, null: false

      t.timestamps
    end
  end
end
