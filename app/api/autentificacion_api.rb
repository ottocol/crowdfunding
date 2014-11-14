require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'json'
require 'app/aplicacion/usuario_BO'
require 'app/dominio/usuario'



class AutentificacionAPI < Sinatra::Base

  configure do
    @@usuario_bo = UsuarioBO.new
    register Sinatra::ActiveRecordExtension
  end

  configure :development do
    register Sinatra::Reloader
  end


  get '/hola' do
    puts 'se ha llamado a /hola'
    'hola'
  end

  post '/login' do
    begin
      datos = JSON.parse(request.body.read)
      if datos['login'] && datos['password']
        usuario = @@usuario_bo.do_login(datos['login'], datos['password'])
        if usuario.nil?
          status 401
          'Login y/o password incorrectos'
        else
          session[:usuario] = usuario.login
          status 200
          'Login OK'
        end
      else
        status 400
        'Falta el login y/o password'
      end
    rescue JSON::ParserError
      status 400
      'JSON incorrecto'
    end
  end

  get '/logout' do
    session[:usuario] = nil
  end


end