require 'app/dominio/usuario'

class UsuarioBO
  def do_login(login, password)
    Usuario.find_by(login: login, password: password)
  end
end