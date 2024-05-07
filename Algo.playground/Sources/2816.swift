import Foundation

/*
 https://logh.tistory.com/12
 블로그 풀이 기록
 // Example of Solution 2816
 var head = ListNode.array(from: [9,1,9,5,0,5,1,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9])
 var newHead = Solution2816.doubleIt(head)

 var ans: [Int] = []
 while newHead != nil {
     ans.append(newHead!.val)
     newHead = newHead?.next
 }

 print("ans : ", ans)

 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

public extension ListNode {
    static func array(from elements: [Int]) -> ListNode? {
        let head: ListNode? = ListNode(elements[0])
        var cur = head
        for i in 1..<elements.count {
            cur?.next = ListNode(elements[i])
            cur = cur?.next
        }
        return head
    }
    
}

public class Solution2816 {
    public static func doubleIt(_ head: ListNode?) -> ListNode? {
        var cur = reversed(head)
        
        var carry =  0
        var curVal = 0
        let head: ListNode? = cur
        var prev: ListNode? = nil
        while cur != nil  {
            curVal = cur!.val * 2 + carry
            carry = curVal / 10
            curVal = curVal - carry * 10
            cur?.val = curVal
            prev = cur
            cur = cur?.next
        }
        
        if carry != 0 {
            prev?.next = ListNode(carry, nil)
        }
        
        return reversed(head)
    }
    
    private static func reversed(_ head: ListNode?) -> ListNode? {
        var cur = head
        var prev: ListNode? = nil
        while cur != nil {
            let next = cur?.next
            cur?.next = prev
            prev = cur
            cur = next
        }
        return prev
    }
}
