//
//  BPDisplayFrequency.swift
//  
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

@objc(BPDisplayFrequency)
open class BPDisplayFrequency: NSObject, @unchecked Sendable, BPTipsConfiguration, BPTipsConfigurationRepresentable {
    @objc(dailyFrequency)
    public static let daily: BPDisplayFrequency = .init(displayFrequency: .daily)
    
    @objc(hourlyFrequency)
    public static let hourly: BPDisplayFrequency = .init(displayFrequency: .hourly)
    
    @objc(immediateFrequency)
    public static let immediate: BPDisplayFrequency = .init(displayFrequency: .immediate)
    
    @objc(monthlyFrequency)
    public static let monthly: BPDisplayFrequency = .init(displayFrequency: .monthly)
    
    @objc(weeklyFrequency)
    public static let weekly: BPDisplayFrequency = .init(displayFrequency: .weekly)
    
    public let displayFrequency: DisplayFrequency
    
    public var tipsConfiguration: TipsConfiguration {
        displayFrequency
    }
    
    private init(displayFrequency: DisplayFrequency) {
        self.displayFrequency = displayFrequency
        super.init()
    }
}
