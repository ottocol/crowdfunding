window.onload = pedir_destacados


function pedir_destacados() {
    var xhr = new XMLHttpRequest()
    xhr.open("GET", "/api/proyectos/destacados", true)
    xhr.onreadystatechange = callback_destacados
    xhr.send()
}



function callback_destacados() {
    if (this.readyState == 4) {
        if (this.status == 200) {
            var destacados = JSON.parse(this.responseText)
            mostrar_destacados(destacados)
        }
    }

}

function mostrar_destacados(lista) {
    var div_destacados = document.getElementById("destacados")
    //obtenemos el texto de la template de Mustache
    var template = document.getElementById("destacados_template").innerHTML
    //a cada elemento de la lista le añadimos la fecha en un formato adecuado para mostrar
    //ya que el original está en AAAA-MM-DD
    for(var i=0;i<lista.length; i++) {
        lista[i].fecha_js = new Date(lista[i].fecha_limite).toLocaleDateString()
    }
    //aplicamos la plantilla Mustache a la lista de datos, obteniendo el HTML
    var html_proyecto = Mustache.render(template, lista)
    //insertamos el HTML en su sitio
    div_destacados.insertAdjacentHTML("beforeend", html_proyecto)
}

