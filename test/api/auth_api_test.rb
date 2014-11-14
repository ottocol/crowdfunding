ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'json'
require 'mocha/mini_test'
require_relative '../test_helper' #para poder ejecutar los test desde RubyMine


require 'app/api/autentificacion_api'

class AutentificacionAPITest < MiniTest::Test
  include Rack::Test::Methods

  def app
    AutentificacionAPI
  end


  def test_login_malformed_json
    post '/login', 'hola mundo'
    assert_equal 400, last_response.status
    assert_equal 'JSON incorrecto', last_response.body
  end


  def test_login_bad_credentials
    UsuarioBO.any_instance.expects(:do_login).with('adi','ado').returns(nil)
    post '/login', {:login=>'adi', :password=>'ado'}.to_json
    assert_equal 401, last_response.status
  end

  def test_login_incorrect_params
    post '/login', {:hola=>'mundo'}.to_json
    assert_equal 400, last_response.status
  end

  def test_login_ok
    u = Usuario.new
    u.login = 'adi'
    u.password = 'adi'
    UsuarioBO.any_instance.stubs(:do_login).with('adi','adi').returns(u)

    #referencia local que vamos a poner como sesión. Cuando el API modifique la sesión
    #modificará el contenido de esta referencia
    sesion =  {}
    post '/login', {:login=>'adi', :password=>'adi'}.to_json, 'rack.session' => sesion
    assert last_response.ok?
    assert_equal 'adi', sesion[:usuario]
  end

  def test_logout
    sesion = {}
    get '/logout', {}, {'rack.session'=>sesion}
    assert last_response.ok?
    assert_nil sesion[:usuario]
  end

end