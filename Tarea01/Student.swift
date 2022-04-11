//
//  Student.swift
//  Tarea01
//
//  Created by Christian Valdivia on 4/04/22.
//

import Foundation

struct Student {
    var name: String
    var lastName: String
    var address: String
    var idNumber: String
    var birthDate: Date
    var nameInitials: String {
        return self.name.prefix(1).uppercased() + self.lastName.prefix(1).uppercased()
    }
    var age: Int {
        
        let calendar = Calendar.current
        return calendar.dateComponents([.year], from: self.birthDate, to: Date()).year ?? 0
    }
    
    func getBirthDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self.birthDate)
    }
}

