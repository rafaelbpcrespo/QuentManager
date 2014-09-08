class CreatePagamentos < ActiveRecord::Migration
  def change
    create_table :pagamentos do |t|
      t.integer :conta_id
      t.decimal :valor

      t.timestamps
    end
  end
end
