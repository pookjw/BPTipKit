//
//  BPTip.swift
//
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
#if canImport(UIKit)
import UIKit.UIImage
#endif
#if canImport(Cocoa)
import Cocoa
#endif
import TipKit

@objc(BPTip)
public protocol BPTip: AnyObject, Sendable {
    @objc var title: NSAttributedString { get }
    @objc optional var message: NSAttributedString? { get }
    
#if os(iOS) || os(watchOS) || os(tvOS) || os(visionOS)
    @objc optional var asset: UIImage? { get }
#elseif os(macOS)
    @objc optional var asset: NSImage? { get }
#endif
    
    @objc optional var tipID: String { get }
    
    @objc optional var rules: [BPTipsRule] { get }
    
    @objc optional var options: [BPTipOption] { get }
    
    @objc optional var actions: [BPTips.Action] { get }
}

struct _BPTip: Tip {
    let bpTip: BPTip
    
    var title: Text {
        .init(AttributedString(bpTip.title))
    }
    
    var message: Text? {
        guard let message: NSAttributedString = bpTip.message ?? nil else {
            return nil
        }
        
        return .init(AttributedString(message))
    }
    
    var asset: Image? {
#if os(iOS) || os(watchOS) || os(tvOS) || os(visionOS)
        guard let asset: UIImage = bpTip.asset ?? nil else {
            return nil
        }
        
        return .init(uiImage: asset)
#elseif os(macOS)
        guard let asset: NSImage = bpTip.asset ?? nil else {
            return nil
        }
        
        return .init(nsImage: asset)
#endif
    }
    
    var id: String {
        guard let uniqueID: String = bpTip.tipID ?? nil else {
            return String(describing: Self.self)
        }
        
        return uniqueID
    }
    
    var rules: [Rule] {
        guard let rules: [BPTipsRule] = bpTip.rules ?? nil else {
            return .init()
        }
        
        return rules
            .map { rule in
                guard let representable: BPTipsRulePresentable = rule as? BPTipsRulePresentable else {
                    fatalError()
                }
                
                return representable.rule
            }
    }
    
    var options: [TipOption] {
        guard let options: [BPTipOption] = bpTip.options ?? nil else {
            return .init()
        }
        
        return options.map { option in
            guard let representable: BPTipOptionRepresentable = option as? BPTipOptionRepresentable else {
                fatalError("Unsupported option: \(option)")
            }
            
            return representable.tipOption
        }
    }
    
    var actions: [Tips.Action] {
        guard let actions: [BPTips.Action] = bpTip.actions else {
            return .init()
        }
        
        return actions.map { $0.action }
    }
}
