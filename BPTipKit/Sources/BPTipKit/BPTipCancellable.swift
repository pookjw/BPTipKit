//
//  BPTipCancellable.swift
//
//
//  Created by Jinwoo Kim on 7/30/23.
//

import Foundation

@objc(BPTipCancellable)
public actor BPTipCancellable: NSObject {
    private let cancelHandler: @Sendable () -> Void
    public private(set) var isCancelled: Bool = false
    
    @objc(initWithCancelHandler:)
    public init(cancelHandler: @escaping @Sendable () -> Void) {
        self.cancelHandler = cancelHandler
        super.init()
    }
    
    deinit {
        cancelHandler()
    }
    
    @objc public func cancel() async {
        guard !isCancelled else { return }
        cancelHandler()
        isCancelled = true
    }
}
