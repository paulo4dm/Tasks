<%@ page import="com.tasks.Categoria" %>



<div class="fieldcontain ${hasErrors(bean: categoriaInstance, field: 'categoria', 'error')} required">
	<label for="categoria">
		<g:message code="categoria.categoria.label" default="Categoria" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="categoria" required="" value="${categoriaInstance?.categoria}"/>

</div>

