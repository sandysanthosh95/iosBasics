import UIKit

// Operaion queue

/*
 1. What is operation?
 
     i) Getting data from server
     ii) Will create operation and execute
 
 2. Diff bw operation and operation quque?
    i) operation quque: create multiple block operation and run in on go
    ii) operation: create queue and execute that operation

 3. what happen if we not set numberOfConcurrentOperation?
    i) If not set the numberOfConcurrentOperation, It will get deafult value. Which is based on system availability.
 For eg lower end device have lesser core compatability so it will take less operation than highter core compatability device
 
 4. OperationQueue VS GCD?
    1) OperationQueue class is the wrapper of GCD. OperationQueue will have some extra advantage than GCD
    2) In GCD we can only cancel the taks using workItem, But in OperationQueue can use cancel, resume, stop
    3) In operationQueue will start the task based on the core availablity(numberOfConcurrentOperation default).
 */

// Operation Example

func operationExample() {
    let blockOperation = BlockOperation()
    blockOperation.addExecutionBlock {
        sleep(1)
        print("1")
    }
    blockOperation.addExecutionBlock {
        sleep(1)
        print("2")
    }
    blockOperation.addExecutionBlock {
        sleep(1)
        print("3")
    }
    // start single operation
    blockOperation.start()
    // It will start all the operation at same time (FIFO). And return based on the Firstout.
    
}
// OperationQueue Example

func operationQueueExample() {
    let blockOperation = BlockOperation()
    blockOperation.addExecutionBlock {
        sleep(1)
        print("1")
    }
    let anotherBlockOperation = BlockOperation()
    anotherBlockOperation.addExecutionBlock {
        sleep(1)
        print("2")
    }
    
    anotherBlockOperation.addDependency(blockOperation)
    let operationQueue = OperationQueue()

    // start multiple operation using queue way 1
    /*
     operationQueue.addOperation(blockOperation)
     operationQueue.addOperation(anotherBlockOperation)
    */

    // start multiple operation using queue way 2
    operationQueue.addOperations([blockOperation, anotherBlockOperation], waitUntilFinished: true)
    print("execution done")
}
operationQueueExample()
