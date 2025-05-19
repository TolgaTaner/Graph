//
//  VertexModel.swift
//  graph
//
//  Created by Tolga Taner on 17.05.2025.
//

import Foundation

public struct VertexModel: Codable {
    public let id: String
    public let edges: [EdgeModel]
    public let pointType: String
}

// MARK: - Edge
public struct EdgeModel: Codable {
    public let id: String
    public let weight: Double
}
