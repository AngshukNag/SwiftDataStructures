//
//  SwiftQueue.swift
//  SwiftAlgorithms
//
//  Created by Angshuk Nag on 19/02/19.
//  Copyright © 2019 DreamWorks. All rights reserved.
//

import Foundation

protocol Initializable {}

extension Int: Initializable {}
extension String: Initializable {}

protocol QueueProtocol {
    associatedtype QueueDataType: Initializable
    func enqueue(_ data: QueueDataType)
    func dequeue() -> QueueDataType?
    func isEmpty() -> Bool
}

protocol LinkedListQueueProtocol: QueueProtocol {
    var front: QueueDataType { get set }
    var back: QueueDataType { get set }
}

protocol ArrayQueueProtocol: QueueProtocol {
    func isFull() -> Bool
    var capacity: Int { get set }
    var front: Int { get set }
    var back: Int { get set }
}

class CircularArrayQueue<QueueDataType: Initializable>: ArrayQueueProtocol {
    private var dataArr: [QueueDataType]!
    private var _front: Int = 0
    private var _back: Int = 0
    private var _capacity: Int = 0
    private(set) var count: Int = 0

    var capacity: Int {
        get {
            return _capacity
        }
        set {
            _capacity = newValue
        }
    }

    var front: Int {
        get {
            return _front
        }
        set {
            _front = newValue
        }
    }

    var back: Int {
        get {
            return _back
        }
        set {
            _back = newValue
        }
    }

    required init(WithCapacity capacity: Int, repeatingValues: QueueDataType) {
        self.capacity = capacity
        self.dataArr = [QueueDataType](repeating: repeatingValues, count: capacity)
    }

    func isFull() -> Bool {
        return count == capacity
    }

    func increaseCapacity(_ newCapacity: Int) {
        self.capacity = newCapacity
    }

    func isEmpty() -> Bool {
        return count == 0
    }

    func enqueue(_ data: QueueDataType) {
        guard !isFull() else {
            print("Queue Overflow error !!!!!! cannot add \(data) to queue")
            return
        }

        dataArr[back] = data
        back = (back + 1) % capacity
        count += 1
    }

    func dequeue() -> QueueDataType? {
        guard !isEmpty() else {
            print("Queue underflow error !!!!!!")
            return nil
        }

        let element = dataArr[front]
        front = (front + 1) % capacity
        count -= 1
        return element
    }

    func printAllElements() {
        var copyFront = front
        for _ in 0..<count {
            print("Element \(copyFront): \(dataArr![copyFront])")
            copyFront = (copyFront + 1) % capacity
        }
    }

}
