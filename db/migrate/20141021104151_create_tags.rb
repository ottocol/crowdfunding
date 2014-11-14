class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
    end

    create_table :proyectos_tags, {:id=>false} do |t|
      t.belongs_to :proyecto
      t.belongs_to :tag
    end
  end
end
