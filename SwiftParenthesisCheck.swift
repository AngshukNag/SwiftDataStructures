//
//  SwiftParenthesisCheck.swift
//  DemoProj1
//
//  Created by Angshuk Nag on 17/02/19.
//  Copyright © 2019 Angshuk Nag. All rights reserved.
//

import Foundation

enum BracketType: String {
    case firstOpen = "("
    case firstClose = ")"
    case secondOpen = "{"
    case secondClose = "}"
    case thirdOpen = "["
    case thirdClose = "]"

    var closeBracket: BracketType? {
        switch self {
        case .firstOpen: return .firstClose
        case .secondOpen: return .secondClose
        case .thirdOpen: return .thirdClose
        default: return nil
        }
    }

    var isOpen: Bool {
        switch self {
        case .firstOpen, .secondOpen, .thirdOpen: return true
        default: return false
        }
    }

    var priority: UInt {
        switch self {
        case .firstOpen, .firstClose: return 1
        case .secondOpen, .secondClose: return 2
        case .thirdOpen, .thirdClose: return 3
        }
    }

    func isPush(_ bracket: BracketType) -> Bool {
        return bracket.isOpen && (bracket.priority <= self.priority)
    }

    func isPop(_ bracket: BracketType) -> Bool {
        return !bracket.isOpen && self.closeBracket == bracket
    }

}

extension Stack where T == BracketType {

    func performActionFor(InputData bracket: BracketType) -> Bool {
        if isEmpty {
            if bracket.isOpen {
                push(Data: bracket)
                return true
            } else {
                return false
            }
        } else {
            if let topBracket = top?.data {
                if topBracket.isPush(bracket) {
                    push(Data: bracket)
                    return true
                } else if topBracket.isPop(bracket) {
                    return pop() != nil
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    }

}

class ParenthesisChecker {
    static func isCorrectExp(_ exp: String) -> Bool {
        let stack = Stack<BracketType>()
        var counter = 0
        for element in exp {
            if let inputElement = BracketType(rawValue: String(element)) {
                if stack.performActionFor(InputData: inputElement) {
                    counter += 1
                } else {
                    print("Parse Error")
                    print("Syntax error at element: \(element)")
                    break
                }
            } else {
                continue
            }
        }
        return stack.isEmpty && counter > 0
    }
    
    static func runCase(_ expression: String) {
        let val = isCorrectExp(expression)
        if val {
            print("Parsing successfull !!")
        }
    }
}
