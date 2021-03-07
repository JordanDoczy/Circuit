//
//  Direction.swift
//  Circuit
//
//  Created by Jordan Doczy on 3/6/21.
//

import Foundation
import SwiftUI

/// bitmask as underlying type
enum Direction: UInt8 {
    
    case n = 0b10000000
    case s = 0b01000000
    case e  = 0b00100000
    case w  = 0b00010000
    case none  = 0b00000000
    
    var description: String {
        switch (self) {
        case .n: return "north"
        case .s: return "south"
        case .e:  return "east"
        case .w:  return "west"
        case .none:  return "none"
        }
    }
    
    var image: Image? {
        switch (self) {
        case .n: return Image(systemName: "arrowtriangle.up.fill")
        case .s: return Image(systemName: "arrowtriangle.down.fill")
        case .e: return Image(systemName: "arrowtriangle.forward.fill")
        case .w: return Image(systemName: "arrowtriangle.backward.fill")
        case .none: return nil
        }
    }
    
    init(_ int: UInt8) {
        // look at most significant bit for direction
        let msb: UInt8 = 1 << (int.bitWidth - int.leadingZeroBitCount - 1)
        self = Direction.init(rawValue: int & msb) ?? .none
    }
    
}
