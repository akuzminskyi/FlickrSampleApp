//
//  UniqueQueue.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct UniqueQueue<T: Hashable> { // UniqQueue
    // TODO: - Replace to OrderedSet
    private var list = [T]()

    mutating func enqueue(_ value: T) {
        if let index = list.firstIndex(of: value) {
            list.remove(at: index)
        }
        list.append(value)
    }

    mutating func dequeue() -> T? {
        guard !list.isEmpty else {
            return nil
        }
        return list.removeFirst()
    }

    mutating func removeAll() {
        list.removeAll()
    }
}
