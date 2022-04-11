//
//  MenuOption.swift
//  Tarea01
//
//  Created by Christian Valdivia on 4/04/22.
//

import Foundation

enum MenuOption: Int {
  case none = 0
  case add = 1
  case list = 2
  case search = 3
  case delete = 4
  case exit = 5
}

struct Menu {
    
    func show() {

        let inputManager = InputManager()
      
        let message = """
        
        ====================================
                   MI APLICACIÓN
        ====================================
        
        1. Ingresar Alumno
        2. Listar Alumnos
        3. Buscar Alumno
        4. Eliminar Alumno
        5. Salir
        
        """
        inputManager.clearConsole()
        print(message)
    }

}
