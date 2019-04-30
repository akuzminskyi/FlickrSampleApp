//
//  Throttler.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class Throttler {
    private var workItem: DispatchWorkItem = DispatchWorkItem(block: { })
    private let queue: DispatchQueue
    private let timeout: TimeInterval

    init(timeout: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.timeout = timeout
        self.queue = queue
    }

    func throttle(_ block: @escaping () -> Void) {
        guard timeout > 0.0 else {
            block()
            return
        }
        workItem.cancel()

        workItem = DispatchWorkItem() {
            block()
        }

        queue.asyncAfter(deadline: .now() + timeout, execute: workItem)
    }
}
