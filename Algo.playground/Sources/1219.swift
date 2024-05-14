import Foundation

/*
 https://logh.tistory.com/18
 백트래킹 + 완전 탐색
 일반적인 백트래킹과 달리 가지치지하기 않음.
 모든 경우를 탐색해 최대값 찾기
 */
class Solution1219 {
    static func getMaximumGold(_ grid: [[Int]]) -> Int {
        var grid = grid
        let rows = grid.count
        let cols = grid[0].count

        var ans = 0

        for r in 0..<rows {
            for c in 0..<cols {
                if grid[r][c] == 0 { continue }
                var temp = backtracking(&grid, r, c)
                ans = max(ans, temp)
            }
        }
        return ans
    }

    // Backtracking
    // 다른 방향에서의 DFS를 통해서 값을 찾기 위해서
    // 콜스택에서 반환될 때 방문표시를 이전상태로 되돌린다. (Backtracking)
    static func backtracking(_ grid: inout [[Int]], _ y: Int, _ x: Int) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        let dx = [1, -1, 0, 0]
        let dy = [0, 0, 1, -1]

        var ans = grid[y][x]

        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            if ny < 0 || ny >= rows { continue }
            if nx < 0 || nx >= cols { continue }
            if grid[ny][nx] == 0 { continue }
            let v = grid[ny][nx]
            grid[ny][nx] = 0
            ans = max(ans, v + dfs(&grid, ny, nx))
            grid[ny][nx] = v
        }

        return ans
    }
}
