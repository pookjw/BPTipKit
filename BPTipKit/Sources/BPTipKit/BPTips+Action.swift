//
//  BPTips+Action.swift
//  
//
//  Created by Jinwoo Kim on 7/30/23.
//

import Foundation
import TipKit

extension BPTips {
    @objc(BPTipsAction)
    open class Action: NSObject, @unchecked Sendable {
        @objc public var actionID: String {
            action.id
        }
        
        @objc(index) public var indexNumber: NSNumber? {
            index as NSNumber?
        }
        
        public var index: Int? {
            action.index
        }
        
        public let action: Tips.Action
        
        public override var hash: Int {
            action.id.hashValue
        }
        
        @objc(initWithActionID:title:disabled:performHandler:)
        public init(actionID: String?, title: NSAttributedString, disabled: Bool, perform handler: @escaping @Sendable () -> Void) {
            let action: Tips.Action = .init(id: actionID, disabled: disabled, perform: handler) {
                .init(AttributedString(title))
            }
            
            self.action = action
            
            super.init()
        }
        
        public init(action: Tips.Action) {
            self.action = action
            super.init()
        }
        
        open override func isEqual(_ object: Any?) -> Bool {
            guard let other: Action = object as? Action else {
                return false
            }
            
            return action.id == other.action.id
        }
    }
}
