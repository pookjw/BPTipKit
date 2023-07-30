//
//  BPTipsDefaultConfiguration.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

@objc(BPTipsDefaultConfiguration)
open class BPTipsDefaultConfiguration: NSObject, @unchecked Sendable, BPTipsConfiguration, BPTipsConfigurationRepresentable {
    public var tipsConfiguration: TipsConfiguration {
        Tips.defaultConfiguration
    }
    
    private override init() {
        super.init()
    }
}
