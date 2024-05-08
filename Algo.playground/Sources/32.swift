import Foundation


/*
 https://logh.tistory.com/14
 블로그 풀이 기록
 */
class Solution32 {
    
    static func longestValidParentheses(_ s: String) -> Int {
        let o: Character = "("
        let c: Character = ")"
        // 문자열을 숫자 배열로 치환
        var digits = s.map {
            if $0 == o {
                return -1
            } else {
                return 0
            }
        }
        
        var stack: [Int] = []
        var temp = 0
        var ans = 0
        
        // digits 를 순회하면서
        // 연속된 1로 만듬
        for (i, d) in digits.enumerated() {
            if d == -1 {
                stack.append(i)
            } else {
                while !stack.isEmpty, let last = stack.last  {
                    if digits[last] == -1 {
                        digits[i] = 1
                        digits[last] = 1
                        break
                    }
                    stack.removeLast()
                }
            }
        }
        
        // 순회하면서 연속된 가장 긴 1의 길이를 구함
        for b in digits {
            if b == 1 {
                temp += 1
                ans = max(ans, temp)
            } else {
                temp = 0
            }
        }
        
        return ans
    }
    
    /*
     스택의 초기 인덱스 -1의 역할
     유효한 시작 지점의 마커: 초기 인덱스 -1은 유효한 괄호 쌍의 시작 지점으로 기능합니다. 괄호 쌍이 완성될 때, 스택의 맨 위 인덱스(stack.last)는 가장 최근의 유효하지 않은 괄호의 위치를 가리키게 됩니다. 따라서 이 인덱스와 현재 처리 중인 괄호의 인덱스의 차이를 계산하여 유효한 괄호 쌍의 길이를 구할 수 있습니다.
     스택이 비었을 때의 처리: 유효한 괄호 쌍을 찾는 과정에서 닫는 괄호를 만났을 때 스택이 비어 있으면, 현재 닫는 괄호는 유효한 괄호 쌍에 포함되지 못합니다. 이 때 스택에 닫는 괄호의 인덱스를 삽입하게 되는데, 이는 새로운 유효하지 않은 괄호 쌍의 시작 지점을 나타냅니다. 초기에 -1을 넣어두지 않으면, 첫 번째 유효한 괄호 쌍을 찾을 때 적절한 시작 지점을 참조할 수 없게 되어 정확한 길이 계산이 어려워집니다.
     길이 계산의 편리함: 예를 들어, 문자열이 ())일 경우를 생각해보겠습니다. 첫 번째 닫는 괄호에서 유효한 쌍이 발견되면 스택에서 (의 인덱스를 제거합니다. 이 때 스택에는 초기값 -1만 남게 되며, 두 번째 닫는 괄호를 처리할 때 스택이 비어 있는 것을 확인하고 해당 인덱스를 스택에 추가합니다. 이렇게 스택에 남아 있는 -1을 사용하여 어떤 유효한 괄호 쌍도 시작되지 않았음을 쉽게 표현할 수 있습니다.
     
     모노토닉 스택 규칙 설명
     열린 괄호를 만나면 무조건 push: 열린 괄호 '('를 만날 때마다 그 인덱스를 스택에 push합니다. 이는 나중에 닫힌 괄호를 만났을 때, 가장 가까운 열린 괄호와 매칭하기 위한 준비입니다.
     닫힌 괄호를 만나면 스택에서 pop: 닫힌 괄호 ')'를 만났을 때 스택에서 pop을 수행합니다. 이는 가장 최근에 저장된 열린 괄호와 매칭하여 유효한 괄호 쌍을 형성하기 위함입니다. 이 때 스택이 비어있다면, 현재 닫힌 괄호는 유효한 쌍을 형성하지 못한 것이므로, 이 닫힌 괄호의 인덱스를 스택에 push하여 새로운 시작 지점을 설정합니다.
     스택이 비지 않았다면 최대 길이 계산: pop을 수행한 후 스택이 비어있지 않다면, 스택의 맨 위에 있는 인덱스(마지막으로 처리되지 않은 열린 괄호의 인덱스)와 현재 인덱스 사이의 거리가 유효한 괄호 쌍의 길이가 됩니다. 이 거리를 계산하여 현재까지의 최대 길이와 비교, 갱신합니다.
     */
    
    static func longestValidParentheses2(_ s: String) -> Int {
        var maxLen = 0
        var stack = [-1] 
        // 스택에 초기 인덱스 -1을 넣어줌
        
        for (i, char) in s.enumerated() {
            if char == "(" {
                // 여는 괄호의 인덱스를 스택에 푸시
                stack.append(i)
            } else {
                // 닫는 괄호를 만났을 때 스택의 맨 위 요소를 팝
                stack.removeLast()
                if stack.isEmpty {
                    // 스택이 비어 있다면, 현재 닫는 괄호의 인덱스를 푸시
                    stack.append(i)
                } else {
                    // 스택이 비어 있지 않다면, 유효한 괄호 쌍의 길이를 갱신
                    maxLen = max(maxLen, i - stack.last!)
                }
            }
        }
        
        return maxLen
    }
}
