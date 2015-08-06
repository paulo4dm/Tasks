<%@ page import="com.tasks.Tarefa" %>

<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'nome', 'error')} required">
	<label for="nome">
		<g:message code="tarefa.nome.label" default="Tarefa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nome" required="" value="${tarefaInstance?.nome}" class="large" placeholder="Estudar e programar" />
</div>

<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'deadline', 'error')} required">
	<label for="deadline">
		<g:message code="tarefa.deadline.label" default="Finalizar até" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="deadline" precision="day"  value="${tarefaInstance?.deadline}" years="${2015..2099}" 
	default="none" noSelection="['':'']" />
</div>

<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'categoria', 'error')} required">
	<label for="categoria">
		<g:message code="tarefa.categoria.label" default="Categoria" />
		<span class="required-indicator">*</span>
	</label>
	<g:if test="${params.action == 'edit'}">
		<g:select name="categoria" from="${com.tasks.Categoria.list()}" optionValue="categoria" optionKey="id" 
		noSelection="['':'- Selecione a categoria -']" value='${tarefaInstance?.categoria.id}' />
	</g:if>
	<g:else>
		<g:select name="categoria" from="${com.tasks.Categoria.list()}" optionValue="categoria" optionKey="id" 
		noSelection="['':'- Selecione a categoria -']" />	
	</g:else>
</div>