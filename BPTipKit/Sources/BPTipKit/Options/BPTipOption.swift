//
//  BPTipOption.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

@objc(BPTipOption)
public protocol BPTipOption: AnyObject, Sendable {
    
}

public protocol BPTipOptionRepresentable: Sendable {
    var tipOption: TipOption { get }
}
