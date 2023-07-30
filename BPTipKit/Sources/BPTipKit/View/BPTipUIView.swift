//
//  BPTipUIView.swift
//
//
//  Created by Jinwoo Kim on 7/29/23.
//

import UIKit
import TipKit
import OSLog

@MainActor
@objc(BPTipUIView)
open class BPTipUIView: UIView {
    @objc public let tipUIView: TipUIView
    
    @objc(initWithBPTip:arrowEdge:actionHandler:)
    public init(_ bpTip: BPTip, arrowEdge: NSDirectionalRectEdge, actionHandler: @escaping (BPTips.Action) -> Void) {
        let _bpTip: _BPTip = .init(bpTip: bpTip)
        
        let edge: Edge
        switch arrowEdge {
        case .top:
            edge = .top
        case .leading:
            edge = .leading
        case .trailing:
            edge = .trailing
        case .bottom:
            edge = .bottom
        default:
            Logger().warning("Not supported arrowEdge.")
            edge = .bottom
        }
        
        let tipUIView: TipUIView = .init(_bpTip, arrowEdge: edge) { action in
            let bpTipsAction: BPTips.Action = .init(action: action)
            actionHandler(bpTipsAction)
        }
        
        self.tipUIView = tipUIView
        super.init(frame: .null)
        
        tipUIView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tipUIView)
        NSLayoutConstraint.activate([
            tipUIView.topAnchor.constraint(equalTo: topAnchor),
            tipUIView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipUIView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tipUIView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
