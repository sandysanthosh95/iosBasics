import UIKit

// Mark:- GCD

/*
    MArk:- sync
 
    Program wait until excecution finishes before the method call return
 
    Sync will run only in main thread
 */

// Sync will run only in main thread

func sycnWithThreadExample() {
    let queue = DispatchQueue.global()
    
    queue.sync {
        print(Thread.isMainThread) // Always return true
    }
}

func sync() {
    DispatchQueue.global().sync {
        sleep(2)
        print("sycn: Inside")
    }
    print("sync: OutSide")
}

/*
    Mark:- async
 
    Program will not wait until excecution finishes return immediately

 */

func async() {
    DispatchQueue.global().async {
        sleep(2)
        print("sycn: Inside")
    }
    print("sync: OutSide")
}

// Mark :- Typef of QoS and the priority

/* public enum QoSClass {
    case background // lowest priority eg: Api or cleanup
    case utility // eg: Not block user (long running process whose user does not follow)
    case default // Mid priority
    case userInitiated eg: Content of email to display(wait for use interaction).
    case userInteractive  // highest priority : eg: Animation
}
*/


// Mark :- Types of queus

/*
  * MainQueue
 * backGroundQueue
 * customQueue
 */


// Mark:- Serial queue will call the block serailly no matter block is sync or async

func serialQueue() {
    let queue = DispatchQueue(label: "")
    queue.async {
        for i in 1...3 {
            print("serial_1", i)
        }
    }
    queue.async {
        for i in 1...3 {
            print("serial_2", i)
        }
    }
}

// Mark:- Main Queue()

// Inside main queue we cannot run sync block. If we run the sync inside main thread. sync block will wait to start excecution because main is already blocked the thread. And also main thread will wait for inner sync to respond so it won't complete the process and throw error

// Its kind of deadlock:

// Deadlock -: In concurrent computing, a deadlock is a state in which each member of a group of actions, is waiting for some other member to release a lock

// Livelock -:  A situation in which two or more processes continuously change their states in response to changes in the other process(es) without doing any useful work.

//  Starvation:  Starvation is the problem that occurs when low priority processes get jammed for an unspecified time as the high priority processes keep executing. A steady stream of higher-priority methods will stop a low-priority process from ever obtaining the processor.

// Error: The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.


func mainQueue() {
    let queue = DispatchQueue.main
    
    queue.async {
        sleep(2)
        for i in 1...3 {
            sleep(1)
            print("serial_1", i)
        }
    }
    queue.async {
        sleep(1)
        for i in 1...3 {
            sleep(1)
            print("serial_2", i)
        }
    }
}

//mainQueue()

// Mark:- Global Queue

func globalQueue() {
    let queue = DispatchQueue.global()
    queue.async {
        sleep(2)
        for i in 1...3 {
            sleep(1)
            print("serial_1", i)
        }
    }
    queue.async {
        sleep(1)
        for i in 1...3 {
            sleep(1)
            print("serial_2", i)
        }
    }
    
}

// globalQueue()


// Mark: DispatchGroup

func dispatchGroup() {
    let queue = DispatchQueue.global()
    let group = DispatchGroup()
        
    queue.async(group: group) {
        sleep(2)
        print("Task 1 done")
    }
    queue.async(group: group) {
        sleep(1)
        print("Task 2 done")
    }
    group.wait()
    print("All task done")
}
//dispatchGroup()

// Mark: DispatchGroup with notifier

func dispatchQueueWithNotifier() {
    
    let queue = DispatchQueue.global()
    let group = DispatchGroup()
    
    group.enter()
    queue.async(group: group) {
        sleep(2)
        print("Group Task 1 done")
        group.leave()
    }
    
    group.enter()
    queue.async(group: group) {
        sleep(1)
        print("Group Task 2 done")
        group.leave()
    }
    group.notify(queue: queue) {
        print("Group All task done")
    }
}

dispatchQueueWithNotifier()


// GCD WorkItem (we can can the task in any time)

// Eg: If user searching in search bar will call the API for every text. This will consume more data for user. To avoid that will add work item with 1 sec delay. If we add 1 sec deley after 1s it start calling API mean time if use enter another text agin. Will cancel the workItem and start the API Call again

func workItemExample() {
    var workItem: DispatchWorkItem?
    workItem?.cancel()
    workItem = DispatchWorkItem {
        for i in 1...10 {
            sleep(1)
            guard let workItem = workItem, !workItem.isCancelled else {
                return
            }
            print(i)
        }
    }
    let queue = DispatchQueue.global()
    queue.asyncAfter(deadline: .now()+1, execute: workItem!)
    workItem?.notify(queue: .main, execute: {
        print("Done printing")
    })
    
    // want to cancel work item after 3 sec
    queue.asyncAfter(deadline: .now()+3) {
        workItem?.cancel()
    }
}
workItemExample()


private let concurrentQueue = DispatchQueue(label: "", attributes: .concurrent)


for value in 1...5 {
    concurrentQueue.async() {
        sleep(2)
        print("async \(value)")
    }
}
for value in 6...10 {
    concurrentQueue.async(flags: .barrier) {
        sleep(1)
        print("barrier \(value)")
    }
}
for value in 11...15 {
    concurrentQueue.async() {
        sleep(1)
        print("sync \(value)")
    }
}



