import UIKit

// Static vs Class

/*
 static and class both associate a method with a class, rather than an instance of a class. The difference is that subclasses can override class methods; they cannot override static methods.

 */

class staticExample {
    static func test() {}
}

class staticSubClass: staticExample {
    // override static func test() {}
    // Errro: Cannot override static method
}

class classExample {
    class func test() {}
}

class classSubClass: classExample {
    override class func test() {} // It can be ovveride in subclass
}

// Mark :- Singleton

// Singleton is a creational design pattern, which ensures that only one object of its kind exists and provides a single point of access to it for any other code. Singleton has almost the same pros and cons as global variables. Although they're super-handy, they break the modularity of your code.

// Default singletons in swift

/*
 
 UserDefaults.shared
 URLSession.shared
 FileManager.default
 
 */


// Disadvantage of using singleton

/*
 
 They are global mutable shared state. Their state is automatically shared across the entire app, and bugs can often start occurring when that state changes unexpectedly.
 
 Managing their lifecycle can be tricky. Since singletons are alive during the entire lifespan of an application, managing them can be really hard
 
 This also makes code that relies on singletons really hard to test, since you can't easily start from a "clean slate" in each test case.
 
 Instead of that we can use depency injection with protocol is the best way to avoid this
 */


class SingletonClass {
    var name: String = "Test"
    static let shared = SingletonClass()
}

print(SingletonClass.shared.name)
