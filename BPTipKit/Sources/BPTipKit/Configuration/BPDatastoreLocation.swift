//
//  BPDatastoreLocation.swift
//
//
//  Created by Jinwoo Kim on 7/29/23.
//

import Foundation
import TipKit

@objc(BPDatastoreLocation)
open class BPDatastoreLocation: NSObject, @unchecked Sendable, BPTipsConfiguration, BPTipsConfigurationRepresentable {
    @objc(applicationDefaultDatastoreLocation)
    public static let applicationDefault: BPDatastoreLocation = .init(datastoreLocation: .applicationDefault)
    
    public let datastoreLocation: DatastoreLocation
    
    public var tipsConfiguration: TipsConfiguration {
        datastoreLocation
    }
    
    @objc
    public convenience init(groupIdentifier: String, directoryName: String? = nil, shouldReset: Bool = false) throws {
        let datastoreLocation: DatastoreLocation = try .init(groupIdentifier: groupIdentifier, directoryName: directoryName, shouldReset: shouldReset)
        self.init(datastoreLocation: datastoreLocation)
    }
    
    @objc
    public convenience init(datastoreLocation: BPDatastoreLocation, shouldReset: Bool = false) {
        let _datastoreLocation: DatastoreLocation = .init(datastoreLocation.datastoreLocation, shouldReset: shouldReset)
        self.init(datastoreLocation: _datastoreLocation)
    }
    
    private init(datastoreLocation: DatastoreLocation) {
        self.datastoreLocation = datastoreLocation
        super.init()
    }
}
