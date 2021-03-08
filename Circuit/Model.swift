//
//  Model.swift
//  Circuit
//
//  Created by Jordan Doczy on 3/7/21.
//

import Foundation

final class Model: ObservableObject {
    
    /// Have to use UInt8 to work with @Published binding requirements
    /// Apple: The @Published attribute is class constrained. Use it with properties of classes, not with non-class types like structures.
//    @Published var buttons: [UInt8] = [17, 64, 32, 16, 0, 65, 64, 65, 32]
    @Published var columns = 3
    @Published var buttons: [UInt8] = load(from: [.e, .s, .e, .w, .e, .s, .s, .n, .e])
    
    static let nilVal = UInt8.min

    private static func load(from directions: [Direction]) -> [UInt8] {
        directions.map { $0.rawValue }
    }
}
