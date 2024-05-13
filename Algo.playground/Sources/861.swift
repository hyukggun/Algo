import Foundation

/*
 https://logh.tistory.com/15
 */
class Solution861 {
    static func matrixScore(_ grid: [[Int]]) -> Int {
        let result1 = flipOrNot(grid)
        let t = transpose(result1)
        let result2 = transpose(flipOrNot2(t))
        return sum(result2)
    }
    
    /// grid의 이진수 합을 구한다
    /// - Parameter grid: 이진수 합을 구할 대상이 되는 이차원 배열
    /// - Returns: 이진수의 합
    private func sum(_ grid: [[Int]]) -> Int {
        var ans = 0
        let rows = grid.count
        for r in stride(from: 0, to: rows, by: 1) {
            let a = grid[r].compactMap { String($0) }.joined()
            let s = Int(a, radix: 2)!
            ans += s
        }
        return ans
    }
    
    /// grid[i]의 수와 grid[i]가 역전된 수 중에 더 큰 경우에만 flip 하도록 하는 함수
    /// - Parameter grid: flip 대상인 이차원 배열
    /// - Returns: flip 된 이차원 배열
    private func flipOrNot(_ grid: [[Int]]) -> [[Int]] {
        let rows = grid.count
        let cols = grid[0].count

        var newGrid = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)

        for r in 0..<rows {
            let a = grid[r].compactMap { String($0) }.joined()
            // XOR 를 이용해서
            // 0 또는 1을 역전시킨다.
            // 0 XOR 1 = 1
            // 1 XOR 0 = 1
            // 0 XOR 0 = 0
            // 1 XOR 1 = 0
            let b = grid[r].compactMap { String($0 ^ 1) }.joined()
            let s = Int(a, radix: 2)!
            let t = Int(b, radix: 2)!
            var p = max(s, t)
            var i = 0
            var temp = String()
            while p > 0 {
                let q = p % 2
                newGrid[r][cols - i - 1] = q
                i += 1
                p >>= 1
            }
        }
        return newGrid
    }
    
    /// 0 의 개수가 더 많은 경우에만 flip 하도록하는 함수
    /// - Parameter grid: 대상이 되는 이차원 배열
    /// - Returns: flip 된 이차원 배열
    private func flipOrNot2(_ grid: [[Int]]) -> [[Int]] {
        let rows = grid.count
        let cols = grid[0].count

        var newGrid = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)

        for r in 0..<rows {
            let a = grid[r].compactMap { String($0) }.joined()
            let b = grid[r].compactMap { String($0 ^ 1) }.joined()
            // a 의 0 의 수를 센다.
            let aZeros = a.filter { $0 == "0" }.count
            var i = 0
            let s = Int(a, radix: 2)!
            let t = Int(b, radix: 2)!
            // a의 0의 수보다 b의 0의 수가 많다면 t
            // 그렇지 않다면 s
            var p = aZeros < cols - aZeros ? s : t
            while p > 0 {
                let q = p % 2
                newGrid[r][cols - i - 1] = q
                i += 1
                p >>= 1
            }
        }
        return newGrid
    }
    
    /// 주어진 이차원 배열 grid를 행과 열을 바꾼다.
    /// - Parameter grid: 바꿀 이차원 배열
    /// - Returns: 행과 열이 바뀐 이차원 배열
    private func transpose(_ grid: [[Int]]) -> [[Int]] {
        let rows = grid.count
        let cols = grid[0].count

        var transposedGrid = [[Int]](repeating: [Int](repeating: 0, count: rows), count: cols)
        for r in 0..<rows {
            for c in 0..<cols {
                transposedGrid[c][r] = grid[r][c]
            }
        }
        return transposedGrid
    }
}
