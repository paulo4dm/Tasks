package com.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TarefaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Tarefa.list(params), model:[tarefaInstanceCount: Tarefa.count()]
    }

    def show(Tarefa tarefaInstance) {
        respond tarefaInstance
        redirect action:"index", method:"GET"
    }

    def create() {
        respond new Tarefa(params)
    }

    def complete(Tarefa tarefaInstance){
        Tarefa.executeUpdate("update Tarefa t set t.completed=true where t.id=$tarefaInstance.id")
        redirect action:"index", method:"GET"
    }

    def countTarefa(){
        render Tarefa.countByCompleted(false)
    }

    @Transactional
    def save(Tarefa tarefaInstance) {
        if (tarefaInstance == null) {
            notFound()
            return
        }

        if (tarefaInstance.hasErrors()) {
            respond tarefaInstance.errors, view:'index'       
            return
        }

        tarefaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tarefa.label', default: 'Tarefa'), tarefaInstance.id])
                redirect tarefaInstance
            }
            '*' { respond tarefaInstance, [status: CREATED] }
        }
    }

    def edit(Tarefa tarefaInstance) {
        respond tarefaInstance
        //INCLUI LISTA DE TAREFAS
        respond Tarefa.list(params), model:[tarefaInstanceCount: Tarefa.count()]
    }

    @Transactional
    def update(Tarefa tarefaInstance) {
        if (tarefaInstance == null) {
            notFound()
            return
        }

        if (tarefaInstance.hasErrors()) {
            respond tarefaInstance.errors, view:'edit'
            return
        }

        tarefaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Tarefa.label', default: 'Tarefa'), tarefaInstance.id])
                redirect tarefaInstance
            }
            '*'{ respond tarefaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Tarefa tarefaInstance) {

        if (tarefaInstance == null) {
            notFound()
            return
        }

        tarefaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarefa.label', default: 'Tarefa'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
