//
//  BPTipsRule.swift
//  
//
//  Created by Jinwoo Kim on 7/30/23.
//

import Foundation
import TipKit

@objc(BPTipsRule)
public protocol BPTipsRule: AnyObject, Sendable {
    
}

public protocol BPTipsRulePresentable {
    var rule: Tips.Rule { get }
}
