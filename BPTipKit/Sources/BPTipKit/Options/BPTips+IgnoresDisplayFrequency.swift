//
//  BPTips+IgnoresDisplayFrequency.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

extension BPTips {
    @objc(BPTipsIgnoresDisplayFrequency)
    open class IgnoresDisplayFrequency: NSObject, @unchecked Sendable, BPTipOption, BPTipOptionRepresentable {
        public let ignoresDisplayFrequency: TipKit.Tip.IgnoresDisplayFrequency
        
        public var tipOption: TipOption {
            ignoresDisplayFrequency
        }
        
        public init(_ ignoresDisplayFrequency: Bool) {
            self.ignoresDisplayFrequency = .init(ignoresDisplayFrequency)
            super.init()
        }
    }
}
