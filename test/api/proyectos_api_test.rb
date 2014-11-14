require 'minitest/autorun'
require 'rack/test'
require 'mocha/mini_test'
require 'json'
require_relative '../test_helper' #para poder ejecutar los test desde RubyMine
require 'app/api/proyectos_api'


class ProyectosAPITest < MiniTest::Test
  include Rack::Test::Methods


  def app
    ProyectosAPI
  end



  def test_hola_2
    assert_equal 2, 1+1
  end

  def test_destacados
    get '/destacados'
    assert_equal last_response.status, 200
    datos = JSON.parse(last_response.body)
    assert_equal 2, datos.length
    assert_equal 'Dar la vuelta al mundo en patinete',
                 datos[0]['titulo']
  end



  def test_crear_proyecto_sin_autentificar
    p = Proyecto.new
    p.titulo = 'Proyecto 1'
    p.descripcion = 'Descripción 1'
    post '/', p.to_json
    assert_equal 401, last_response.status
  end


  def test_crear_proyecto_ok
    p = Proyecto.new
    p.titulo = 'Proyecto 1'
    p.descripcion = 'Descripción 1'
    ProyectoBO.any_instance.expects(:crear_proyecto).with(anything, anything).returns(p)
    post '/', p.to_json, 'rack.session'=>{:usuario=>'adi'}
    assert_equal 200, last_response.status
    datos = JSON.parse(last_response.body)
    assert_equal datos['titulo'], 'Proyecto 1'
  end

  def test_crear_proyecto_con_JSON_incorrecto
    post '/', 'hola pepito', 'rack.session'=>{:usuario=>'adi'}
         assert_equal 400, last_response.status
  end


  def test_obtener_proyecto_OK
    get '/1'
    assert last_response.ok?
    datos = JSON.parse(last_response.body)
    assert_equal datos['titulo'], 'Reconstruir la estrella de la muerte'
  end

  def test_obtener_proyecto_no_existente
    get '/42'
    assert_equal 404, last_response.status
  end

  def test_obtener_proyectos_de_usuario
    get '/mios', {}, 'rack.session'=>{:usuario=>'adi'}
    assert 200, last_response.status
    datos = JSON.parse(last_response.body)
    assert_equal 2, datos.length
    assert_equal datos[0]['titulo'], 'Reconstruir la estrella de la muerte'
  end

  def test_obtener_proyectos_de_usuario_sin_autentificar
    get '/mios'
    assert 401, last_response.status
  end
end