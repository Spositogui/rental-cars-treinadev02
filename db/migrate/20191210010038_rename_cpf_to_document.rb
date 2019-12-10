class RenameCpfToDocument < ActiveRecord::Migration[5.2]
  def change
    rename_column :clients, :cpf, :document
  end
end
