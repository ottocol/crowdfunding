require_relative '../test_helper' #para poder ejecutar los test desde RubyMine
require 'minitest/autorun'
require 'active_record'
require 'database_cleaner'
require 'app/aplicacion/proyecto_BO'
require 'app/dominio/proyecto'
require 'app/dominio/tag'


class ProyectoBOTest < Minitest::Test
  def setup
    ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        #cuidado, el path de la BD es relativo al fichero actual (__FILE__)
        #si cambiáis de sitio el test, habrá que cambiar el path
        :database  => File.join(File.dirname(__FILE__),'..', '..','db','cf_test.sqlite3')
    )
    #DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  def test_listar_destacados
    lista = ProyectoBO.new.listar_destacados()
    assert_equal 2, lista.length
    assert_equal 1500, lista[0]['objetivo']
  end

  def test_crear_proyecto_ok
    datos = {'titulo'=>'a ver', 'descripcion'=>'prueeeba'}
    p = ProyectoBO.new.crear_proyecto(datos, 'adi')
    assert_equal 'a ver', p.titulo
    assert_equal 'adi', p.usuario.login
  end

  def test_crear_proyecto_sin_titulo
    datos = {'descripcion'=>'nada'}
    error = assert_raises ValidacionError do
      ProyectoBO.new.crear_proyecto(datos, 'adi')
    end
    puts error.errores[:titulo]

  end


  def test_listar_tags_de_proyecto
      proyecto = ProyectoBO.new.obtener(1)
      assert_equal 2, proyecto.tags.length
      proyecto = ProyectoBO.new.obtener(2)
      assert_equal 1, proyecto.tags.length
  end













end