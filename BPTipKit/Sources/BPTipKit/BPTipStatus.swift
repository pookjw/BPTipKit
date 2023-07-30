//
//  BPTipStatus.swift
//  
//
//  Created by Jinwoo Kim on 7/30/23.
//

import Foundation
import TipKit

@objc(BPTipStatus)
open class BPTipStatus: NSObject, @unchecked Sendable {
    @objc public var isAvailable: Bool {
        tipStatus == .available
    }
    
    @objc public var isInvalidated: Bool {
        tipStatus == .invalidated
    }
    
    @objc public var isPending: Bool {
        tipStatus == .pending
    }
    
    @objc public var shouldDisplay: Bool {
        tipStatus.shouldDisplay
    }
    
    public var tipStatus: Tips.Status {
        _bpTip.status
    }
    
    public override var hash: Int {
        tipStatus.hashValue
    }
    
    private let _bpTip: _BPTip
    
    @objc(initWithBPTip:)
    public init(bpTop: BPTip) {
        _bpTip = .init(bpTip: bpTop)
        super.init()
    }
    
    @objc
    public func observeStatusUpdates(handler: @escaping @Sendable () -> Void) -> BPTipCancellable {
        let task: Task<Void, Never> = .init { [_bpTip] in
            for await _ in _bpTip.statusUpdates {
                handler()
            }
        }
        
        let cancellable: BPTipCancellable = .init {
            task.cancel()
        }
        
        return cancellable
    }
    
    @objc
    public func observeShouldDisplayUpdates(handler: @escaping @Sendable (_ shouldDisplay: Bool) -> Void) -> BPTipCancellable {
        let task: Task<Void, Never> = .init { [_bpTip] in
            for await newValue in _bpTip.shouldDisplayUpdates {
                handler(newValue)
            }
        }
        
        let cancellable: BPTipCancellable = .init {
            task.cancel()
        }
        
        return cancellable
    }
}
