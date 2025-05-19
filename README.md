# Graph Nearest Node Finder (Dijkstra + PriorityQueue)

This project parses graph data from a JSON file and constructs a directed weighted graph. It then finds the nearest node with a specific `pointType` (e.g., `"wc"`) using **Dijkstra's algorithm**, optimized with a custom **PriorityQueue** implementation for performance.

## Features

- Parses node and edge data from JSON.
- Identifies nodes by their `pointType` attribute (e.g., `"wc"`, `"point"`).
- Uses Dijkstra's algorithm to find the shortest path to the nearest target node.
- Utilizes a custom PriorityQueue based on a binary heap for efficiency.
