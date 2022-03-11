import UIKit

// Mark :- Race condition

// Multiplr thread trying to access share shared resoruce race condition will occur

// eg: You have bank account with balance 5000. You trying to get 4000 and same time your friend trying to access same account with 2000. Race condition may occur

// Race condition without lock

func raceConditionWithoutLockExample() {
    var balance = 5000
    let queue = DispatchQueue.global()
    
    queue.async {
        if balance >= 4000 {
            Thread.sleep(forTimeInterval: 3)
            balance -= 4000
            print("current bal", balance)
        } else {
            print("Insuff bal")
        }
    }
    queue.async {
        if balance >= 2000 {
            Thread.sleep(forTimeInterval: 3)
            balance -= 2000
            print("current bal", balance)
        } else {
            print("Insuff bal")
        }
    }
}

// Race condition with lock

func raceConditionWithLockExample() {
    var balance = 5000
    let queue = DispatchQueue.global()
    let lockOperation = NSLock()
    
    queue.async {
        lockOperation.lock()
        if balance >= 4000 {
            Thread.sleep(forTimeInterval: 3)
            balance -= 4000
            print("current bal", balance)
        } else {
            print("Insuff bal")
        }
        lockOperation.unlock()
    }
    queue.async {
        lockOperation.lock()
        if balance >= 2000 {
            Thread.sleep(forTimeInterval: 3)
            balance -= 2000
            print("current bal", balance)
            lockOperation.unlock()
        } else {
            print("Insuff bal")
        }
        lockOperation.unlock()
    }
}

raceConditionWithLockExample()
