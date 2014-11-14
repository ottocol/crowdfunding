require 'active_record'

class Tag < ActiveRecord::Base
  #Relación M a N: un proyecto está etiquetado con muchas tags
  #una tag está en muchos proyectos
  has_and_belongs_to_many :proyectos
end