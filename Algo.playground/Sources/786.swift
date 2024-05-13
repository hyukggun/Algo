import Foundation

/*
 출처: https://logh.tistory.com/16 [LogH:티스토리]
 풀이방법:
 1. heap 을 이용한 풀이 O(N^2 * logN)
 2. Binary Search 를 이용한 풀이
*/
class Solution786 {
    static func kthSmallestPrimeFraction(_ arr: [Int], _ k: Int) -> [Int] {
        var heap = Heap<[Int]>(compareFunc: { left, right in
            let lValue = Double(left[0]) / Double(left[1])
            let rValue = Double(right[0]) / Double(right[1])
            return lValue < rValue
        })

        var fractions = [[Int]]()
        let n = arr.count - 1
        for i in stride(from: n, to: -1, by: -1) {
            for j in 0..<i {
                fractions.append([arr[j], arr[i]])
            }
        }

        var t = 0
        heap.container.append(contentsOf: fractions)
        heap.makeHeap()

        var ans: [[Int]] = []
        while !heap.isEmpty && t < k {
            ans.append(heap.pop()!)
            t += 1
        }

        return ans.last!
    }
}

