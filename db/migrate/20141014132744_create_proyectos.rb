class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      #El id no lo añadimos ya que lo hace automáticamente Active Record
      t.string :titulo
      t.text :descripcion
      #cantidad monetaria que queremos alcanzar
      t.integer :objetivo
      t.date :fecha_limite
      t.boolean :destacado
      #por el momento tampoco añadimos las relaciones
      #Lo haremos en la siguiente iteración
    end
  end
end
