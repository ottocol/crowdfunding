require 'app/dominio/proyecto'
require 'app/dominio/usuario'
require 'app/util/validacion_error'

class ProyectoBO
  def obtener(id)
    Proyecto.find_by_id(id)
  end

  def listar_destacados
    Proyecto.where(destacado:true).order(:fecha_limite)
  end

  def listar_del_usuario(login)
    usuario = Usuario.find_by_login(login)
    if !usuario.nil?
      return usuario.proyectos
    end
  end

  def crear_proyecto(datos, login)
    p = Proyecto.new(datos)
    u = Usuario.find_by_login(login)
    if u.nil?
      return nil
    elsif p.valid?
      p.usuario = u
      p.save()
      return p
    else
      raise ValidacionError.new(p.errors)
    end
  end

end