class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      #El id no lo añadimos ya que lo hace automáticamente Active Record
      t.string :login
      t.string :password
    end

    change_table :proyectos do |t|
      t.belongs_to :usuario
    end
  end
end
