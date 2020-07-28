//
//  ThreadSafetyDictionary.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

public class SynchronizedStringDictionary {
    private var dict: [String: String] = [:]
    private let accessQueue = DispatchQueue(label: "SynchronizedDictionaryAccess", attributes: .concurrent)

    public func add(newElement: String, for key: String) {
        self.accessQueue.async(flags:.barrier) {
            self.dict[key] = newElement
        }
    }

    public func removeAll() {
        self.accessQueue.async(flags:.barrier) {
            self.dict.removeAll()
        }
    }

    public var count: Int {
        var count = 0

        self.accessQueue.sync {
            count = self.dict.count
        }

        return count
    }


    public subscript(key: String) -> String? {
        set {
            self.accessQueue.async(flags:.barrier) {
                self.dict[key] = newValue
            }
        }
        get {
            var element: String?
            self.accessQueue.sync {
                element = self.dict[key]
            }
            return element
        }
    }
}
