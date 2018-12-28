//
//  Console.swift
//
//  Created by Kirby on 11/19/17.
//

import Foundation

public enum OutputStyle {
    case black
    case purple
    case blue
    case green
    case red
}

public class Console {
    private static let textColorReset = "\u{001B}[;m"

    public static func writeMessage(_ message: String, styled: OutputStyle = .black) {

        switch styled {
        case .black:
            print("\u{001B}[;m\(message)")
            
        case .purple:
            print("\u{001B}[0;35m\(message)", textColorReset)
            
        case .blue:
            print("\u{001B}[0;34m\(message)", textColorReset)
            
        case .green:
            print("\u{001B}[0;32m\(message)", textColorReset)
            
        case .red:
            
            print("\u{001B}[0;31m\(message)", textColorReset)
            // Below outputs to the STDERR
            // Kinda like nslog
            //      fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    public static func writeMessage(_ error: Error) {
        print("\u{001B}[0;31m\(error)", textColorReset)
    }

    
    public static func writeSpacer() {
        Console.writeMessage("=================================== \n")
    }
    
    public static func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        
        guard let strData = String(data: inputData, encoding: String.Encoding.utf8) else {
            fatalError("Could not convert to string")
        }
        
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    public static func getInput(for question: String, styled: OutputStyle = .black) -> String {
        Console.writeMessage(question, styled: styled)
        return Console.getInput()
    }

    /**
     Keep asking same question until a valid or exit string is inputted
     - Parameters:
        - question: The question to keep repeating to the user
        - invalidText: Text to display to user if they enter an invalid input
        - validInputs: Array of strings that are valid and will finish the loop
        - exitInputs: Array of strings that will cause the app to exit
     */
    public static func waitForValidInput(question: String, invalidText: String, validInputs: [String], exitInputs: [String]) {
        var isValidInput = false
        
        while !isValidInput {
            let input = getInput(for: question, styled: .blue)
            
            if validInputs.contains(input) {
                isValidInput = true
            } else if exitInputs.contains(input) {
                exit(0)
            } else {
                Console.writeMessage(invalidText, styled: .red)
            }
        }
    }
}
