package com.tasks

class Tarefa {
	String nome
	Date deadline
	Categoria categoria

    static constraints = {
    	nome()
    	deadline()
    	categoria()
    }
}
