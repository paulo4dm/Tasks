package com.tasks

class Tarefa {
	String nome
	Date deadline
	Categoria categoria
	Boolean completed = false

    static constraints = {
    	nome()
    	deadline()
    	categoria()
    	completed()
    }
}
