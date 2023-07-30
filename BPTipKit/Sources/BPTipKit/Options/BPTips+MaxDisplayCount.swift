//
//  BPTips+MaxDisplayCount.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

extension BPTips {
    @objc(BPTipsMaxDisplayCount)
    open class MaxDisplayCount: NSObject, @unchecked Sendable, BPTipOption, BPTipOptionRepresentable {
        public let maxDisplayCount: TipKit.Tip.MaxDisplayCount
        
        public var tipOption: TipOption {
            maxDisplayCount
        }
        
        public init(_ maxDisplayCount: Int) {
            self.maxDisplayCount = .init(maxDisplayCount)
            super.init()
        }
    }
}
