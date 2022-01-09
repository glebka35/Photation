//
//  ThreadSafetyDictionary.swift
//  Photation
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

public class SynchronizedStringDictionary<T> {

//    MARK: - Properties

    private var dict: [String: T] = [:]
    private let accessQueue = DispatchQueue(label: "SynchronizedDictionaryAccess", attributes: .concurrent)

    public var count: Int {
           var count = 0

           self.accessQueue.sync {
               count = self.dict.count
           }

           return count
       }

//    MARK: - Actions

    public func add(newElement: T, for key: String) {
        self.accessQueue.async(flags:.barrier) {
            self.dict[key] = newElement
        }
    }

    public func removeAll() {
        self.accessQueue.async(flags:.barrier) {
            self.dict.removeAll()
        }
    }

    public subscript(key: String) -> T? {
        set {
            self.accessQueue.async(flags:.barrier) {
                self.dict[key] = newValue
            }
        }
        get {
            var element: T?
            self.accessQueue.sync {
                element = self.dict[key]
            }
            return element
        }
    }
}
