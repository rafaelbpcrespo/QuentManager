class ChangeTableNameEntradasToAcompanhamentos < ActiveRecord::Migration
  def change
    rename_table :entradas, :acompanhamentos
  end
end
