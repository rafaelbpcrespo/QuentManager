class AddFieldsToAcompanhamento < ActiveRecord::Migration
  def change
    add_column :acompanhamentos, :quantidade, :integer
    add_column :acompanhamentos, :valor, :decimal, precision: 5, scale: 2
  end
end
