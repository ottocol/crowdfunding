require 'active_record'

class Usuario < ActiveRecord::Base
  #Relación 1 a N, lado del 1
  has_many :proyectos
end
