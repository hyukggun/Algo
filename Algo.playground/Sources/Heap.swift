import Foundation

public struct Heap<Element> {
    public var container: [Element]
    public var compareFunc: (Element, Element) -> Bool
    public var count: Int { container.count }
    
    var isEmpty: Bool { container.isEmpty }
    
    public init(container: [Element], compareFunc: @escaping (Element, Element) -> Bool) {
        self.container = container
        self.compareFunc = compareFunc
    }
    
    public init(compareFunc: @escaping (Element, Element) -> Bool) {
        self.container = []
        self.compareFunc = compareFunc
    }
    
    public mutating func heapify() {
        guard count > 1 else { return }
        /*
        (count - 2) / 2 인 이유
        마지막 노드는 count - 1
        (count - 1 - 1) / 2 는 부모 노드를 나타냄
         */
        for i in stride(from: (count - 2) / 2, through: 0, by: -1) {
            heapifyDown(from: i)
        }
    }
    
    private mutating func heapifyDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var candidate = parent
            
            if left < count && !compareFunc(container[candidate], container[left]) {
                candidate = left
            }
            
            if right < count && !compareFunc(container[candidate], container[right]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            container.swapAt(parent,  candidate)
            parent = candidate
        }
    }
    
    public mutating func insert(_ value: Element) {
        container.append(value)
        heapifyUp(from: count - 1)
    }
    
    private mutating func heapifyUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && compareFunc(container[child], container[parent]) {
            container.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    public mutating func pop() -> Element? {
        guard count > 0 else { return nil }
        
        let retValue = container[0]
        container.swapAt(0, count - 1)
        container.removeLast()
        
        if count > 0 {
            heapifyDown(from: 0)
        }
        
        return retValue
    }
}

