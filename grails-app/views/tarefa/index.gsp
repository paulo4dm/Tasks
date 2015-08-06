
<%@ page import="com.tasks.Tarefa" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'tasks.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'tarefa.label', default: 'Tarefa')}" />
		<title>Lista de Tarefas</title>
	</head>
	<header>
		<span>Lista de Tarefas</span>
	</header>
	<body>
		<main id="taskPage">
			%{-- FORM DE CRIAÇÃO DE TAREFAS --}%
			<section id="taskCreation" class="not">
				<div id="create-tarefa" role="main">
					
					<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
					</g:if>
					<g:hasErrors bean="${tarefaInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${tarefaInstance}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
					</g:hasErrors>
					<g:form url="[resource:tarefaInstance, action:'save']" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
						<br>
						<fieldset>
							<g:submitButton name="create" class="btn" value="Salvar tarefa" />
							<input type='reset' class="btn" value='Limpar tarefa' />
						</fieldset>
					</g:form>
				</div>
			</section>

			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>

			<section>
				<table>
				<thead>
						<tr>
						
							<g:sortableColumn property="nome" width="40%" title="${message(code: 'tarefa.nome.label', default: 'Nome')}" />
						
							<g:sortableColumn property="deadline" width="15%" title="${message(code: 'tarefa.deadline.label', default: 'Deadline')}" />
						
							<g:sortableColumn property="categoria" width="15%" title="${message(code: 'tarefa.categoria.label', default: 'Categoria')}" />

							<g:sortableColumn property="categoria" width="30%" title="Ações" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${tarefaInstanceList}" status="i" var="tarefaInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td class="${tarefaInstance?.completed ? 'taskCompleted':''}">
								${fieldValue(bean: tarefaInstance, field: "nome")}
							</td>
						
							<td class="${tarefaInstance?.completed ? 'taskCompleted':''}"><g:formatDate format="dd/MM/yyyy" date="${tarefaInstance.deadline}" /></td>
						
							<td class="${tarefaInstance?.completed ? 'taskCompleted':''}">${fieldValue(bean: tarefaInstance, field: "categoria.categoria")}</td>

							<td>
								<nav>
									<g:form url="[resource:tarefaInstance, action:'delete']" method="DELETE">
										<g:if test="${!tarefaInstance?.completed}">
											<g:link class="btn" action="edit" resource="${tarefaInstance}">Editar</g:link>
											<g:link class="btn" action="complete" resource="${tarefaInstance}">Completar</g:link>
										</g:if>						
										<g:actionSubmit class="btn" action="delete" value="Deletar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
									</g:form>								
								</nav>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
			
				<div class="pagination">
					<g:paginate total="${tarefaInstanceCount ?: 0}" />
				</div>
			</div>
				<nav>
					<a href="#" id="btnAddTask" onclick="document.getElementById('taskCreation').className = '';">Adicionar tarefa</a>
				</nav>
			</section>

			<footer>Você tem <g:include controller="tarefa" action="countTarefa" /> tarefas</footer>
		</main>		
	</body>
</html>
