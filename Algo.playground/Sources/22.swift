import Foundation

/*
 https://logh.tistory.com/11
 Generate Parenthesis Solution
 Category: Backtracking, DFS
 */
public class Solution22 {
    
    public static func generateParenthesis(_ n: Int) -> [String] {
        var ans = Set<String>()
        backtracking(n, opened: 0, closed: 0, String(), store: &ans)
        return Array(ans)
    }
    
    private static func backtracking(_ n: Int, opened: Int, closed: Int, _ s: String, store: inout Set<String>) {
        if opened == n && closed == n {
            store.insert(s)
            return
        }
        
        if s.isEmpty {
            backtracking(n, opened: opened + 1, closed: closed, s + "(", store: &store)
        } else {
            if opened < n {
                backtracking(n, opened: opened + 1, closed: closed, s + "(", store: &store)
            }
            if opened > closed && closed < n {
                backtracking(n, opened: opened, closed: closed + 1, s + ")", store: &store)
            }
        }
    }
}
