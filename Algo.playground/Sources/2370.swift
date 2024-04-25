import Foundation


/// https://leetcode.com/problems/longest-ideal-subsequence
public class Solution2370 {
    
    public init() {}
    
    let a = Int("a".unicodeScalars.first!.value)
    
    public func longestIdealString(_ s: String, _ k: Int) -> Int {
        var count = [Int](repeating: 0, count: 26)
        for c in s {
            let v = Int(c.unicodeScalars.first!.value) - a
            let left = max(0, v - k)
            let right = min(25, v + k)
            for j in left...right {
                count[v] = max(count[j], count[v])
            }
            count[v] += 1
        }
        return count.max()!
    }
}
