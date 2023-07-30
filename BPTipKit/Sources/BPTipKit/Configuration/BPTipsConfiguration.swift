//
//  BPTipsConfiguration.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

@objc(BPTipsConfiguration)
public protocol BPTipsConfiguration: AnyObject, Sendable {
    
}

// All BPTipsConfiguration objects must conform this protocol.
public protocol BPTipsConfigurationRepresentable: Sendable {
    var tipsConfiguration: TipsConfiguration { get }
}
