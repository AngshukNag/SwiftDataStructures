//
//  SwiftExpressionStack.swift
//  DemoProj1
//
//  Created by Angshuk Nag on 17/02/19.
//  Copyright © 2019 Angshuk Nag. All rights reserved.
//

import Foundation

enum ExpressionStackOperation {
    case push
    case pop
    case lastPop
}

enum ExpressionRepresentationType {
    case infix
    case postfix
    case prefix
}

enum OperatorType: String {
    case multiply = "*"
    case divide = "/"
    case plus = "+"
    case minus = "-"
    case leftBracket = "("
    case rightBracket = ")"

    var priority: Int {
        switch self {
        case .plus, .minus: return 1
        case .multiply, .divide: return 2
        default: return 3
        }
    }

    func getOperation(_ inputElement: OperatorType) -> ExpressionStackOperation {
        switch inputElement {
        case .rightBracket: return self == .leftBracket ? .lastPop : .pop
        default: return inputElement.priority < self.priority && self != .leftBracket ? .pop : .push
        }
    }

}

extension Stack where T == OperatorType {

    func performOperation(_ element: OperatorType) -> String? {
        guard let topElement = top, let topData = topElement.data else {
            return nil
        }
        let operation = topData.getOperation(element)
        switch operation {
        case .push:
            push(Data: element)
            return nil
        case .pop, .lastPop:
            let outputString = popAndOutput(element)
            if element != .rightBracket {
                push(Data: element)
            }
            return outputString
        }
    }

    func popAndOutput(_ element: OperatorType) -> String {
        if let topData = pop() {
            let operation = topData.getOperation(element)
            switch operation {
            case .push, .lastPop: return ""
            case .pop: return topData.rawValue + popAndOutput(element)
            }
        } else {
            return ""
        }
    }

}

class ExpressionConverter {

    static func convertInfixToPostFix(_ inputExp: String) -> String? {
        guard ParenthesisChecker.isCorrectExp(inputExp) else {
            return nil
        }
        let stack = Stack<OperatorType>()
        var outputString = ""
        for element in inputExp {
            outputString += (parseElement(String(element), stack: stack) ?? "")
        }

        while !stack.isEmpty {
            if let topData = stack.pop() {
                outputString += topData.rawValue
            }
        }
        
        return outputString
    }

    static func parseElement(_ element: String, stack: Stack<OperatorType>) -> String? {
        guard let operatorType = OperatorType(rawValue: element) else {
            return element
        }

        if stack.isEmpty {
            stack.push(Data: operatorType)
            return nil
        } else {
            return stack.performOperation(operatorType)
        }
        
    }

}
