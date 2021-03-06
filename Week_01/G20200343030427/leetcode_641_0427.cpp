#include <vector>
//#include <iostream>
class MyCircularDeque {
private:
    int capacity;
	vector<int> arr;
	int front;
    int rear;
public:
    /** Initialize your data structure here. Set the size of the deque to be k. */
    MyCircularDeque(int k) {
        front = 0;
        rear = 0;
        capacity = k + 1;
        arr.assign(capacity, 0);
    }
    
    /** Adds an item at the front of Deque. Return true if the operation is successful. */
    bool insertFront(int value) {
        if (isFull())
        	return false;
        //-1是因为指针要前移，元素才能插入队列前端;+ capacity并取模是为了避免边界条件时数组越界
        front = (front - 1 + capacity) % capacity; 
        arr[front] = value;
        return true;
    }
    
    /** Adds an item at the rear of Deque. Return true if the operation is successful. */
    bool insertLast(int value) {
        if (isFull())
        	return false;
		arr[rear] = value;
        rear = (rear + 1) % capacity;
        return true;
    }
    
    /** Deletes an item from the front of Deque. Return true if the operation is successful. */
    bool deleteFront() {
        if (isEmpty())
        	return false;
        front = (front + 1) % capacity;
        return true; 
    }
    
    /** Deletes an item from the rear of Deque. Return true if the operation is successful. */
    bool deleteLast() {
        if (isEmpty())
        	return false;
        rear = (rear - 1 + capacity) % capacity;
        return true;
    }
    
    /** Get the front item from the deque. */
    int getFront() {
        if (isEmpty())
        	return -1;
        return arr[front];
    }
    
    /** Get the last item from the deque. */
    int getRear() {
    	if (isEmpty())
        	return -1;
		//+ capacity 是为了防止rear == 0时数组越界
        return arr[(rear -1 + capacity) % capacity];
    }
    
    /** Checks whether the circular deque is empty or not. */
    bool isEmpty() {
        return front == rear;
    }
    
    /** Checks whether the circular deque is full or not. */
    bool isFull() {
        return (rear + 1) % capacity == front;
    }
};