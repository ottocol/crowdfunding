#Crowdfunding: aplicación de ejemplo para ADI 14-15



##Pruebas unitarias con *Jasmine*

En Javascript hay multitud de *frameworks* para pruebas unitarias. Vamos a ver aquí cómo usar uno de los más conocidos, [Jasmine](http://jasmine.github.io).

###Instalación y configuración

Hay varias formas de instalar la librería. Para aplicaciones Ruby en el servidor la más sencilla es usando una gema llamada `jasmine`. Las instrucciones de instalación detalladas se pueden consultar [en la web](http://jasmine.github.io/2.1/ruby_gem.html), pero las vamos a describir también aquí.

En el `Gemfile` incluir dicha gema en el grupo de `test`

```ruby
group :test do
  #otras gemas
  .... 
  gem 'jasmine'
end
```

Como siempre, ejecutar `bundle install` en la terminal (o `Tools > Bundler > Install` desde Rubymine) para actualizar las dependencias. Se instalará `jasmine` junto con unas cuantas dependencias de la librería.

Ahora ejecutamos en la terminal `jasmine init`, estando en la raíz del proyecto, lo que hará que se creen unos cuantos ficheros de configuración y se le añada una nueva tarea al `Rakefile`.

> Como siempre, es posible que sea necesario preceder la orden anterior de `bundle exec`: `bundle exec jasmine init`

Ahora configuramos Jasmine editando el archivo `spec/javascript/support/jasmine.yml` (nótese que estos directorios los ha creado el `jasmine init`). En el apartado donde pone `src_files` (línea 13) se deben especificar los directorios donde tenemos `.js`, para que Jasmine pueda cargarlos. Recordemos que en nuestro proyecto están en `app/web/public/js`. Modificamos la línea 14 para que quede así:


    src_files:
      - app/web/public/js/**/*.js

Con esto indicamos que son archivos `.js` y que pueden estar en cualquier subdirectorio por debajo de `app/web/public/js`

###La primera prueba con Jasmine

####Suites y pruebas

Vamos a probar una función muy simple, que puedes colocar por ejemplo en un nuevo archivo `app/web/public/js/saludo.js`

    function hola_mundo() {
        return "hola mundo"
    }

Los *tests* hay que colocarlos en cualquier subcarpeta de `spec` y deben llamarse `*spec.js`. Esto está configurado así por defecto en la línea 54 del `jasmine.yml` así que como ves puede cambiarse sin mucho problema.

    //Archivo spec/javascripts/saludo_spec.js
    describe("Suite de pruebas muy simple", function() {
        it("saluda con 'hola mundo'", function() {
            expect(saludo()).toBe("hola mundo");
        });
    });

Con `describe` especificamos la `suite` y con `it` cada una de las pruebas. El primer parámetro de cada uno de ellos es un título, y el segundo una función en la que se implementa la *suite* o la prueba en sí, respectivamente.

Dentro de cada test usamos una o varias *expectations* (`expect`), en las que comprobamos si algo cumple con una determinada condición. Las condiciones se especifican con un *matcher*, que es una función que comprueba si se cumple una condición y devuelve por tanto un valor booleano. Podemos comprobar igualdad, desigualdad, si algo es `undefined`, si un array contiene o no un determinado valor, etc. Jasmine cuenta con un [amplio conjunto de *matchers*](http://jasmine.github.io/2.1/introduction.html#section-Included_Matchers).

####Ejecutar las pruebas

>Antes de ejecutar las pruebas debemos modificar ligeramente el archivo `proyectos.js` para compatibilizarlo con Jasmine. Al principio del archivo estábamos modificando el `window.onload`, pero Jasmine depende de este evento. En realidad no es una buena práctica modificar el `window.onload` ya que si otro `.js` ya lo ha hecho su modificación se "pierde". Es mejor hacer

> 
    window.addEventListener('load', pedir_destacados)

que añade un nuevo *listener* a los que ya existían en lugar de sustituir al anterior manejador.


La gema `jasmine` instala un pequeño "sitio web" a través del que podemos ver la ejecución de las pruebas. En la consola ejecutar `rake jasmine` (o `bundle exec rake jasmine` si lo anterior da error). Se pondrá en marcha el servidor por el puerto `8888`. Para ver el resultado de las pruebas nos podemos ir a un navegador y acceder a `http://localhost:8888` 



