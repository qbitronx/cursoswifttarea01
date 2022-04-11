//
//  InputManager.swift
//  Tarea01
//
//  Created by Christian Valdivia on 4/04/22.
//

import Foundation

protocol InputRequest {
    var message: String { get }
    var errorMessage: String { get }
    func validate(_ inputValue: String) -> Bool
    func showErrorMessage()
 }

extension InputRequest {
    
    func getInput() -> String {
        
        self.showMessage()
        let inputValue = readLine() ?? ""
        if self.validate(inputValue) {
            return inputValue
        } else {
            self.showErrorMessage()
            return self.getInput()
        }
    }
    
    func getInput() -> Int {
        
        self.showMessage()
        let inputValue = readLine() ?? ""
        if self.validate(inputValue) {
            return Int(inputValue) ?? 0
        } else {
            self.showErrorMessage()
            return self.getInput()
        }
    }
    
    
    func getInput() -> Date {
        var date : Date?
        var inputValue: String
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        repeat {
            self.showMessage()
            inputValue = readLine() ?? ""
            if (self.validate(inputValue)) {
                
                date = dateFormatter.date(from: inputValue)
            } else {
               self.showErrorMessage()
            }
        } while !self.validate(inputValue)
        
        return date ?? Date()
    }

    
    func showErrorMessage() {
        print("""
        
        ⚠️ ERROR: \(self.errorMessage)
        Presione Enter para continuar ↩️
        
        """)
        let _ = readLine()
    }
    
    func showMessage() {
        print("~ ✅ ~ \(self.message):")
    }
    
}


struct InputManager { }

extension InputManager {
    
    struct Text: InputRequest {
        let message: String
        let errorMessage: String
        let minLength: Int
        var maxLength: Int = Int.max
        
        func validate(_ inputValue: String) -> Bool {
            (self.minLength...self.maxLength).contains(inputValue.count)
        }
        
    }
}

extension InputManager {
    
    struct Integer: InputRequest {
        let message: String
        let errorMessage: String
        let range: ClosedRange<Int>
        
        func validate(_ inputValue: String) -> Bool {
            guard let value = Int(inputValue) else { return false }
            return self.range.contains(value)
        }
        
        func showErrorMessage() {
            print("""
            
            ⚠️ ERROR: \(self.errorMessage)
            El valor ingresado deberá estar entre \(range.min() ?? 0) y \(range.max() ?? 0)
            Presione Enter para continuar ↩️
            
            """)
            let _ = readLine()
        }
    }
}

extension InputManager {
    
    struct _Date: InputRequest {
        let message: String
        let errorMessage: String
        
        func validate(_ inputValue: String) -> Bool {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            if let _ = dateFormatter.date(from: inputValue) {
                return true
            }
            return false
        }
        
    }
}

extension InputManager {
    func clearConsole() {
        let separator = Array(repeating: "\n", count: 20).joined()
        print("", terminator: separator)
    }
}
