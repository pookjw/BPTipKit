//
//  BPTips.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

let open = Tips.Event(id: "Ts")
@objc(BPTips)
open class BPTips: NSObject, @unchecked Sendable {
    @objc(configureWithConfigurations:completionHandler:)
    public static func configure(with configurations: [BPTipsConfiguration]) async throws {
        let tipsConfigurations: [TipsConfiguration] = configurations
            .map { configuration in
                guard let representable: BPTipsConfigurationRepresentable = configuration as? BPTipsConfigurationRepresentable else {
                    fatalError("Unsupported configuration: \(configuration)")
                }
                
                return representable.tipsConfiguration
            }
        
        
        return try await Tips.configure {
            tipsConfigurations
        }
    }
    
    @objc
    public static func showAllTips() {
        Tips.showAllTips()
    }
    
    private override init() {
        super.init()
    }
}
