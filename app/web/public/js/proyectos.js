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
    var template = document.getElementById("destacados_template").innerHTML

    for(var i=0;i<lista.length; i++) {
        lista[i].fecha_js = new Date(lista[i].fecha_limite).toLocaleDateString()
    }
    var html_proyecto = Mustache.render(template, lista)
    div_destacados.insertAdjacentHTML("beforeend", html_proyecto)
}

