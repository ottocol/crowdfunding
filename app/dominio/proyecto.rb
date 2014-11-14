require 'active_record'

class Proyecto < ActiveRecord::Base
  #validación de datos
  #Consultar http://guides.rubyonrails.org/active_record_validations.html
  validates :titulo, presence: true

  #relación 1 a N, (lado del N)
  belongs_to :usuario
  #relación M a N
  has_and_belongs_to_many :tags
end
