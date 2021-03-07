//
//  State.swift
//  Circuit
//
//  Created by Jordan Doczy on 3/6/21.
//

import Foundation

protocol ToggleButtonState: Hashable {
    var isOn: Bool { get set }
    var isActive: Bool { get set }
    var direction: Direction { get }
}

/// storage as a bit mask
/// bit 1 controls the toggle state isOn
/// bit 2 controls the active state isActive
/// bit 4 and 8 not used
/// bit 16 designates a west direction
/// bit 32 designates a east direction
/// bit 64 designates a south direction
/// bit 128  designates a north direction
extension UInt8: ToggleButtonState {
    struct StateConstants {
        static let isOn: UInt8 = 0b1
        static let isActive: UInt8 = 0b10
    }
    
    init(direction: Direction = .none, isOn: Bool = false, isActive: Bool = false) {
        self = direction.rawValue
        if isOn { self |= StateConstants.isOn }
        if isActive { self |= StateConstants.isActive }
    }
    
    var isOn: Bool {
        get {
            (self & StateConstants.isOn) > 0
        }
        set {
            self ^= StateConstants.isOn
        }
    }
    
    var isActive: Bool {
        get {
            (self & StateConstants.isActive) > 0
        }
        set {
            self ^= StateConstants.isActive
        }
    }
    
    var direction: Direction {
        get {
            Direction.init(self)
        }
        set { 
            self ^= direction.rawValue
            self |= newValue.rawValue
        }
    }
    
}
