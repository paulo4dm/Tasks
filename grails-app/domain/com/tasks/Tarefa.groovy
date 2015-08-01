package com.tasks

class Tarefa {
	String nome
	Date deadline
	String categoria

    static constraints = {
    	nome()
    	deadline()
    	categoria()
    }
}
