/**
 * Ejemplo de uso:
 * var arbol = new ArbolBinario();
 * arbol.add({id: 12, nombre: "juan pérez de la O"});
 * arbol.add({id: 4, nombre: "otra persona"});
 * arbol.add({id: 16, nombre: "alguien más"});
 * ... luego podemos acceder a sus propiedades del tipo:
 * arbol.root.derecha; esto nos regresará lo que hay a la derecha
 * arbol.find(12); Debe de buscar el ID 12.
 */

class ArbolBinario {
	constructor() {
		this.root = null;
	}
	isEmpty() {
		return this.root === null;
	}
	add (val) {
		if (this.isEmpty()) {
			this.root = new Nodo(val)
			return;
		}
		var aux = this.root;
		while (aux) {
			// OJO AQUÍ: usa la propiedad "id" para organizar el árbol. Hay que cambiar
			// esta propiedad en caso de que deseemos organizar el arbol por otra propiedad del objeto.
			// También podemos quitar la propiedad tal cual y manejar enteros, pero no se recomienda
			if (val < aux.id) {
				if (aux.izquierdo) {
					aux=aux.izquierdo;
				} else {
					aux.izquierdo=new Nodo(val);
				}
			} else { 
				// vamos hacia la derecha
				if (aux.derecho) {
					aux = aux.derecho;
				} else {
					aux.derecho=new Nodo(val);
				}
			}
		}
	}
	addRecursive (val, n=this.root) {
		if (!n) {
			this.root = new Nodo(val);
			return;
		}
		if (val < n.id) {
		// a la izquierda
			if (n.izquierdo) {
				return this.addRecursive(val, n.izquierdo);
			}
			n.izquierdo = new Nodo(val);
		} else { 
			// vamos hacia la derecha
			if (n.derecho) {
				return this.addRecursive(val, n.derecho);
			}
			n.derecho = new Nodo(val);
		}
	}
	//OJO AQUÍ: esta función busca por ID, pero se puede cambiar la propiedad por otra
	find(val, n=this.root) {
		if (n.id === val) {
			return n;
        }
		if (n.id < val) {
			return this.find(val, n.derecho);
		} else if (n.id > val) {
			return this.find(val, n.izquierdo);
		}
	}
}

class Nodo {
	constructor(val) {
		this.valor = val;
		this.derecho = null;
		this.izquierdo = null;
	}
}
