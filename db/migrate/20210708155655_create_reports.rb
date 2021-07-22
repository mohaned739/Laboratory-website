class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :rbc_count
      t.integer :wbc_count
      t.integer :plat_count
      t.text :comment
      t.references :user , foreign_key: true
      t.integer :doc_id
      t.timestamps
    end
  end
end
