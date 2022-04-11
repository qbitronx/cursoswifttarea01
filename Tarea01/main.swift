//
//  main.swift
//  Tarea01
//
//  Created by Christian Valdivia on 2/04/22.
//1

import Foundation

var option: MenuOption
let menu = Menu()
let inputManager = InputManager()
var studentsManager = StudentsManager()

repeat {
    inputManager.clearConsole()

    menu.show()
    
    let optionValue = InputManager.Integer(message: "Ingrese el número de opción que desea ver",
                                     errorMessage:  "La opción ingresada es incorrecta",
                                     range: 1...5)
    
    option = MenuOption(rawValue: optionValue.getInput()) ?? .none

    switch option {
        case .none: print("OPCIÓN NO RECONOCIDA")
        case .add: doOptionAddStudent()
        case .list: doOptionListStudents()
        case .search: doOptionSearchStudentByIdNumber()
        case .delete: doOptionDeleteStudent()
        case .exit: print("ESTOY EN LA OPCIÓN SALIR")
    }
                
    print("\nPresione ENTER tecla para continuar...")
    let _ = readLine()
        
} while option != .exit && option != .none

func doOptionAddStudent () {
    inputManager.clearConsole()
  
    print(
    """
    ##############################
          INGRESAR ALUMNO
    ##############################
    """
    )

    let name = InputManager.Text(message: "Ingrese Nombre: ", errorMessage: "Debe ingresar Nombre", minLength: 1 )
    let lastName = InputManager.Text(message: "Ingrese Apellido: ", errorMessage: "Debe ingresar Apellido", minLength: 1)
    let address = InputManager.Text(message: "Ingrese Dirección: ", errorMessage: "Debe ingresar Dirección", minLength: 1)
    let idNumber = InputManager.Text(message: "Ingrese Nro. Documento: ", errorMessage: "Debe ingresar Nro.Documento", minLength: 1)
    let birthDate = InputManager._Date(message: "Ingrese Fecha Nacimiento: ", errorMessage: "Debe ingresar Fecha de Nacimiento (dd/mm/yyyy)")
    
    let student = Student(name: name.getInput(),
                          lastName: lastName.getInput(),
                          address: address.getInput(),
                          idNumber: idNumber.getInput(),
                          birthDate: birthDate.getInput())

    if (studentsManager.addStudent(student)) {
        print("\n~ ✅ ~ ALUMNO INGRESADO CORRECTAMENTE\n")
    } else {
        print("\n ⚠️ : ALUMNO CON DOC IDENTIDAD INGRESADO YA EXISTE\n")
    }
}

func doOptionListStudents () {
    let allStudents: [Student]

    inputManager.clearConsole()

    print(
    """
    ##############################
          LISTA DE ALUMNOS
    ##############################

    """
    )

    allStudents = studentsManager.getAllStudents().sorted(by: { $0.lastName < $1.lastName })

    if (allStudents.count > 0) {

        print(
        """
        
        Nombre de Alumno
        =========================================================
        
        """)

        allStudents.forEach { student in
            print("\(student.nameInitials) - \(student.name) \(student.lastName)")
        }
    } else {
        print ("\n ⚠️ LISTA DE ESTUDIANTES VACIA\n")
    }

}

func doOptionSearchStudentByIdNumber () {
  
    inputManager.clearConsole()
    let studentsFound : [Student]
    
    let optionTitle = """
    ##############################
            BUSCAR ALUMNO
    ##############################
    """

    print(optionTitle)

    let idNumber = InputManager.Text(message: "Ingrese Nro. Documento: ", errorMessage: "Debe ingresar Nro.Documento", minLength: 1)

    studentsFound = studentsManager.searchStudentByIdNumber(idNumber.getInput())

    let resultTitle = """

    RESULTADO DE BUSQUEDA
    ==============================================================
    """
    
    print(resultTitle)

    
    if (studentsFound.count > 0) {
        studentsFound.forEach { student in
                print("Nombre: \(student.name)\n" +
                      "Apellido: \(student.lastName)\n" +
                      "Dirección: \(student.address)\n" +
                      "Nro. Documento: \(student.idNumber)\n" +
                      "Fecha Nacimiento: \(student.getBirthDateString())\n" +
                      "Iniciales: \(student.nameInitials)\n" +
                      "Edad: \(student.age)\n")
            
        }
    } else {
        print ("\n ⚠️ ALUMNO(S) NO ENCONTRADO(S)\n")
    }

}

func doOptionDeleteStudent () {

    var isDeletedStudent = false

    inputManager.clearConsole()

    let optionTitle = """
    ##############################
          ELIMINAR ALUMNO
    ##############################
    """

    print(optionTitle)

    let idNumber = InputManager.Text(message: "Ingrese Nro. Documento: ", errorMessage: "Debe ingresar Nro.Documento", minLength: 1)
    
    isDeletedStudent = studentsManager.deleteStudentByIdNumber( idNumber.getInput() )

    if (isDeletedStudent) {
        print ("~ ✅ ~ ALUMNO(S) ELIMINADO(S)\n")
    } else {
        print ("\n ⚠️ NO SE ENCONTRO ALUMNO A ELIMINAR\n")
    }

}

