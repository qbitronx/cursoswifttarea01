//
//  StudentsManager.swift
//  Tarea01
//
//  Created by Christian Valdivia on 4/04/22.
//

import Foundation

struct StudentsManager {
    
    private var students : [Student] = []

    func getAllStudents() -> [Student]  { return students }

    mutating func addStudent (_ student: Student) -> Bool {
        var isStudentAdded = false
        if (searchStudentByIdNumber(student.idNumber).count == 0) {
            self.students.append(student)
            isStudentAdded = true
        }
        return isStudentAdded
    }

    func searchStudentByIdNumber( _ idNumber : String ) -> Array<Student> {
        var studentsFound = [Student]()
        
        students.forEach { student in
                  if (student.idNumber == idNumber) {
                studentsFound.append(student)
            }
        }
        return studentsFound
    }
    
    mutating func deleteStudentByIdNumber( _ idNumber : String ) -> Bool {
        var isDeletedStudent = false

        students.forEach { student in
            if let idx = students.firstIndex(where: { _student in _student.idNumber == student.idNumber }) {
                students.remove(at: idx)
                isDeletedStudent = true
            }
            
        }
        return isDeletedStudent
    }

} 
