//
//  SwiftStack.swift
//  DemoProj1
//
//  Created by Angshuk Nag on 15/02/19.
//  Copyright © 2019 Angshuk Nag. All rights reserved.
//

import Foundation

class Node<T> {
    var data: T?
    var next: Node?

    init(WithData nodeData: T) {
        next = nil
        self.data = nodeData
    }

}

class Stack<T> {
    var top: Node<T>?
    private(set) var count: Int = 0
    var isEmpty: Bool {
        return top == nil
    }

    func push(Data data: T) {
        if top == nil {
            top = Node(WithData: data)
        } else {
            let newNode = Node(WithData: data)
            newNode.next = top
            top = newNode
        }
        count += 1
    }

    func pop() -> T? {
        guard top != nil else {
            print("Stack Underflow Error !!!!")
            return nil
        }

        let oldTop = top
        top = top?.next
        count -= 1
        return oldTop?.data
    }

}
