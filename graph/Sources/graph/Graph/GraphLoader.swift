//
//  GraphLoader.swift
//  graph
//
//  Created by Tolga Taner on 17.05.2025.
//

import Foundation

public final class GraphLoader {
    
    public var graph: [String: VertexModel] = [:]
    
    struct Constant {
        static let graph: String = "graph"
        static let type: String = "json"
    }
    
    enum LoadingError: Error {
        case jsonParse
        case jsonNotFound
        
        var localizedDescription: String {
            switch self {
            case .jsonNotFound:
                return "json not found"
            case .jsonParse:
                return "json parse error"
            }
        }
    }
    
    public init() {}
    
    public func load() throws -> [VertexModel] {
        guard let url = Bundle.module.url(forResource: Constant.graph,
                                          withExtension: Constant.type)
        else {
            throw LoadingError.jsonNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([VertexModel].self, from: data)
            for node in items {
                graph[node.id] = node
            }
            return items
        }
        catch { throw LoadingError.jsonParse }
    }
    
    struct PriorityQueue<Element> {
        private var heap: [Element]
        private let areInIncreasingOrder: (Element, Element) -> Bool

        init(sort: @escaping (Element, Element) -> Bool) {
            self.heap = []
            self.areInIncreasingOrder = sort
        }

        var isEmpty: Bool {
            heap.isEmpty
        }

        mutating func enqueue(_ element: Element) {
            heap.append(element)
            siftUp(from: heap.count - 1)
        }

        mutating func dequeue() -> Element? {
            guard !heap.isEmpty else { return nil }
            if heap.count == 1 { return heap.removeFirst() }

            let first = heap[0]
            heap[0] = heap.removeLast()
            siftDown(from: 0)
            return first
        }

        private mutating func siftUp(from index: Int) {
            var child = index
            let element = heap[child]
            var parent = (child - 1) / 2

            while child > 0 && areInIncreasingOrder(element, heap[parent]) {
                heap[child] = heap[parent]
                child = parent
                parent = (child - 1) / 2
            }
            heap[child] = element
        }

        private mutating func siftDown(from index: Int) {
            let count = heap.count
            let element = heap[index]
            var parent = index

            while true {
                let left = 2 * parent + 1
                let right = 2 * parent + 2
                var candidate = parent

                if left < count && areInIncreasingOrder(heap[left], heap[candidate]) {
                    candidate = left
                }
                if right < count && areInIncreasingOrder(heap[right], heap[candidate]) {
                    candidate = right
                }

                if candidate == parent { break }

                heap[parent] = heap[candidate]
                parent = candidate
            }
            heap[parent] = element
        }
    }
    
    // This is the variance of Dijkstra algoritm.
    public func findNearestNode(from startID: String,
                                targetType: String) -> VertexModel? {
        
        guard graph[startID] != nil else { return nil }

            var visited = Set<String>()
            var distances: [String: Double] = [:]
            var priorityQueue = PriorityQueue<(id: String, cost: Double)> { $0.cost < $1.cost }
            // In Dijkstra algorithm, in the beginning, all distances between nodes should be infinity.
            for nodeID in graph.keys {
                distances[nodeID] = Double.infinity
            }
            distances[startID] = 0
            priorityQueue.enqueue((id: startID, cost: 0))

            while !priorityQueue.isEmpty {
                guard let current = priorityQueue.dequeue() else { break }
                let currentID = current.id

                guard !visited.contains(currentID),
                      let currentNode = graph[currentID] else { continue }

                visited.insert(currentID)

                if currentNode.pointType == targetType {
                    return currentNode
                }

                for edge in currentNode.edges {
                    let neighborID = edge.id
                    let newDistance = (distances[currentID] ?? .infinity) + edge.weight

                    if newDistance < (distances[neighborID] ?? .infinity) {
                        distances[neighborID] = newDistance
                        priorityQueue.enqueue((id: neighborID, cost: newDistance))
                    }
                }
            }
            return nil
    }
}
