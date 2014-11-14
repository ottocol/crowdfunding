require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'sinatra/activerecord'

require 'app/dominio/proyecto'
require 'app/aplicacion/proyecto_BO'
require 'app/util/validacion_error'


class ProyectosAPI < Sinatra::Base

  configure do
    puts 'configurando API de proyectos...'
    @@proyecto_bo = ProyectoBO.new
    register Sinatra::ActiveRecordExtension
  end

  configure :development do
    register Sinatra::Reloader
  end

  #Obtener proyectos destacados
  get '/destacados' do
    @@proyecto_bo.listar_destacados().to_json()
  end



  #crear proyecto
  post '/' do
    login_actual = check_auth()
    begin
      datos = JSON.parse(request.body.read)
      p = @@proyecto_bo.crear_proyecto(datos, login_actual)
      status 200
      p.to_json
    rescue JSON::ParserError => e          # catch(Exception e)
      status 400
      "Error en el JSON: #{e}"
    end
  end

  #listar proyectos del usuario actual
  get '/mios' do
    login_actual = check_auth()
    lista = @@proyecto_bo.listar_del_usuario(login_actual)
    if lista.nil?
      status 404
      'Error con el usuario actual'
    else
      status 200
      lista.to_json
    end
  end

  #Obtener proyecto dado su id.
  #Tiene que ir al final, porque la URL encaja también con '/mios' y '/destacados'
  get '/:id' do
    id = params[:id]
    proyecto = @@proyecto_bo.obtener(id)
    if proyecto.nil?
      status 404
      "No existe el proyecto con id #{id}"
    else
      status 200
      proyecto.to_json
    end
  end


  helpers do
    def check_auth
      login_actual = session[:usuario]
      if (login_actual.nil?)
        halt 401, 'No estás autentificado'
      end
      return login_actual
    end
  end


end