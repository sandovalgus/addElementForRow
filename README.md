# README
Para esta version de prueba se creaon dos modelos, Person y Products.
Para hacer mas simple la comprension se define que una persona tiene muchos productos, y un producto corresponde a una sola persona.

Pasos a seguir
-------------

En **views/people/_form** se agrego lo siguiente al formulario:

  ```
  <div class="field">
    <p>Productos</p>
    <%= form.fields_for :products do |product| %>
    <%= render 'product_fields', f: product %>
    <%end%>  
    <div class="btn-adjunto-doc">
    <%= link_to_add_fields 'Adjuntar Documento <i class="fa fa-paperclip fa-1x" aria-hidden="true"></i>'.html_safe, form, :products %> 
    </div>
</div>

  ```
En **views/people** se creo el archivo _product_fields.html.erb y el siguiente codigo en el:

  ```
<fieldset class="scheduler-border-doc">
  <div class="field">
    <%= f.label :name %>
    <%= f.text_field :name, id: :product_name %>
  </div>
  <div class="field">
    <%= f.label :price %>
    <%= f.text_field :price, id: :product_price %>
  </div>
  <div class="field">
    <%= f.label :cant %>
    <%= f.number_field :cant, id: :product_cant %>
  </div>
    <div class="row">
    <div class="col-md-12">
      <%= f.hidden_field :_destroy %>
      <%= link_to  'Eliminar Documento <i class="fa fa-times fa-1x" aria-hidden="true"></i>'.html_safe, '#', class: "remove_fields btn btn-danger" %>
    </div>
  </div>
</fieldset>
  ```
  
  En **app/helpers/people_helper.rb** se agrego el siguiente codigo:
  
  ```
  module PeopleHelper
		def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
		end
		def link_to_add_fields(name, f, association)
		    new_object = f.object.send(association).klass.new
		    id = new_object.object_id
		    fields = f.fields_for(association, new_object, child_index: id) do |document|
		      render(association.to_s.singularize + "_fields", f: document)
		    end
	    link_to(name, '', class: "add_fields btn btn-success", data: { id: id, fields: fields.gsub("\n", "")})
	end
end
  ```

En **assets/javascripts/people.coffee** se agrego el siguiene codigo :

  ```
jQuery ->
  $(document).on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()
  $(document).on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  ```

En **models/person** debe ir lo siguiente :

  ```
accepts_nested_attributes_for :products,  allow_destroy: true 
  ```

A tener en cuenta, el proyecto debe tener **jquery**, puede utilizar a **gena jquery-rails**. 
