//
//  BPTipsParameterRule.swift
//
//
//  Created by Jinwoo Kim on 7/30/23.
//

import Foundation
import TipKit

extension PredicateExpressions {
    public struct _Equal<
        LHS : PredicateExpression,
        RHS : PredicateExpression
    > : PredicateExpression
    where
        LHS.Output == RHS.Output,
        LHS.Output : Equatable
    {
        public typealias Output = Bool
        
        public let lhs: LHS
        public let rhs: RHS
        
        public init(lhs: LHS, rhs: RHS) {
            self.lhs = lhs
            self.rhs = rhs
        }
        
        public func evaluate(_ bindings: PredicateBindings) throws -> Bool {
            try lhs.evaluate(bindings) == rhs.evaluate(bindings)
        }
    }
    
    public static func build_Equal<LHS, RHS>(lhs: LHS, rhs: RHS) -> _Equal<LHS, RHS> {
        _Equal(lhs: lhs, rhs: rhs)
    }
}

extension PredicateExpressions._Equal : StandardPredicateExpression where LHS : StandardPredicateExpression, RHS : StandardPredicateExpression {}

extension PredicateExpressions._Equal : Codable where LHS : Codable, RHS : Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(lhs)
        try container.encode(rhs)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        lhs = try container.decode(LHS.self)
        rhs = try container.decode(RHS.self)
    }
}

@available(macOS 9999, iOS 9999, tvOS 9999, watchOS 9999, *)
extension PredicateExpressions.Equal : Sendable where LHS : Sendable, RHS : Sendable {}

extension PredicateExpressions {
    struct NSPredicateExpression<Value: PredicateExpression>: PredicateExpression {
        let value: Value
        let nsPredicate: NSPredicate
        
        func evaluate(_ bindings: PredicateBindings) throws -> Bool {
            let value = try value.evaluate(bindings)
            
            return nsPredicate.evaluate(with: value)
        }
    }
}

extension PredicateExpressions.NSPredicateExpression : StandardPredicateExpression where Value : StandardPredicateExpression {}

extension PredicateExpressions.NSPredicateExpression : Codable where Value : Codable {
    enum CodingKeys: String, CodingKey {
        case value
        case nsPredicate
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        let nsPredicateData: Data = try container.decode(Data.self, forKey: .nsPredicate)
        guard let nsPredicate: NSPredicate = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSPredicate.self, from: nsPredicateData) else {
            fatalError()
        }
        
        value = try container.decode(Value.self, forKey: .value)
        self.nsPredicate = nsPredicate
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        let nsPredidateData: Data = try NSKeyedArchiver.archivedData(withRootObject: nsPredicate, requiringSecureCoding: true)
        
        try container.encode(value, forKey: .value)
        try container.encode(nsPredidateData, forKey: .nsPredicate)
    }
}

extension BPTips {
    @objc(BPTipsParameterRule)
    open class ParameterRule: NSObject, @unchecked Sendable, BPTipsRule, BPTipsRulePresentable {
        @objc public let parameter: Parameter
        public let rule: Tips.Rule
        
        @objc(initWithParameter:predicate:)
        public init(parameter: Parameter, predicate: NSPredicate) {
            self.parameter = parameter
            rule = .init(parameter.parameter) { value in
//                PredicateExpressions.NSPredicateExpression(value: value, nsPredicate: predicate)
                PredicateExpressions._Equal(lhs: PredicateExpressions.Value(true), rhs: PredicateExpressions.Value(true))
            }
        }
    }
    
    @objc(BPTipsParameter)
    open class Parameter: NSObject, @unchecked Sendable {
        @objc public var parameterValue: ParameterValue {
            get {
                parameter.getValue()
            }
            set {
                parameter.setValue(newValue)
            }
        }
        
        public let parameter: Tips.Parameter<ParameterValue>
        
        @objc(initWithDefaultValue:key:isTransient:)
        public init(defaultValue: ParameterValue, key: String, isTransient: Bool) {
            parameter = .init((ParameterValue.self, key), value: defaultValue, isTransient: isTransient)
        }
    }
    
    @objc(BPTipsParameterValue)
    public class ParameterValue: NSObject, NSSecureCoding, Codable, @unchecked Sendable {
        enum CodingKeys: String, CodingKey {
            case value = "value"
        }
        public static var supportsSecureCoding: Bool {
            true
        }
        
        @objc public let value: NSValue
        
        public override var hash: Int {
            value.hashValue
        }
        
        @objc(initWithValue:)
        public init(value: NSValue) {
            self.value = value
            super.init()
        }
        
        public required init?(coder: NSCoder) {
            guard let value: NSValue = coder.decodeObject(of: NSValue.self, forKey: "value") else {
                return nil
            }
            
            self.value = value
            
            super.init()
        }
        
        public required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
            let valueData: Data = try container.decode(Data.self, forKey: .value)
            guard let value: NSValue = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSValue.self, from: valueData) else {
                fatalError()
            }
            
            self.value = value
            super.init()
        }
        
        public func encode(with coder: NSCoder) {
            coder.encode(value, forKey: "value")
        }
        
        public func encode(to encoder: Encoder) throws {
            let valueData: Data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
            var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(valueData, forKey: .value)
        }
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let other: ParameterValue = object as? ParameterValue else {
                return false
            }
            
            return value == other.value
        }
    }
}
