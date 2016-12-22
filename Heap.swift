//
//  Heap.swift
//  Hearth
//
//  Created by Sathvik Koneru on 5/21/16.
//  Copyright © 2016 Sathvik Koneru. All rights reserved.
//

import Foundation
import UIKit


//a heap is a specialized tree-based data structure that satisfies the heap property
//this heap structure returns the ones with the smallest priorities
//that is why I made my frequencies negative - so that when we pop the addresses 
//with greatest "magnitude" are outputted
class PriorityQueue<T> {
    
    //local variable to hold the data structure
    var heap = Array<(Int, T)>()
    
    //this method adds a value to the heap structure in the tree structure
    func push(priority: Int, item: T) {
        heap.append((priority, item))
        
        if heap.count == 1 {
            return
        }
        
        var current = heap.count - 1
        while current > 0 {
            let parent = (current - 1) >> 1
            if heap[parent].0 <= heap[current].0 {
                break
            }
            (heap[parent], heap[current]) = (heap[current], heap[parent])
            current = parent
        }
    }
    
    //this method "pops" and returns the value with lowest priority
    func pop() -> (Int, T) {
        (heap[0], heap[heap.count - 1]) = (heap[heap.count - 1], heap[0])
        let pop = heap.removeLast()
        heapify(0)
        return pop
    }
    
    //this method "heapifies" or orders the heap variable
    //into following the heap data structre
    //every time you pop or push you will need to implement this to make sure the heap
    //variable conforms
    func heapify(index: Int) {
        let left = index * 2 + 1
        let right = index * 2 + 2
        var smallest = index
        
        if left < heap.count && heap[left].0 < heap[smallest].0 {
            smallest = left
        }
        if right < heap.count && heap[right].0 < heap[smallest].0 {
            smallest = right
        }
        if smallest != index {
            (heap[index], heap[smallest]) = (heap[smallest], heap[index])
            heapify(smallest)
        }
    }
    
    //getting total entries
    var count: Int {
        get {
            return heap.count
        }
    }
}
