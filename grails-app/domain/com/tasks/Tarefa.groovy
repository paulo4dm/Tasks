package com.tasks

class Tarefa {
	String nome
	Date deadline
	Categoria categoria
	Boolean completed = false

	static mapping = {
	    sort "deadline"
	}

    static constraints = {
    	nome()
    	deadline()
    	categoria()
    	completed()
    }
}
