import UIKit

// Mark :- Any Vs AnyObject

// All data type in swift is value type
/*
 Any:
 
 1. It can represent any type of class, struct, enum including function and optional types or you can say anything at all.
 2. If your dictionary will be used only within Swift code, then you should use Any because your types (Int, Double, Float, String, Array, and Dictionary) are not objects.
 
 AnyObject:
 
 1. It refers to any instance of a class. It’s useful when you are working with reference type only. It’s equivalent to ‘id’ in Objective-C.
 2. If you will be passing your dictionary to Objective-C routines that expect an NSDictionary, then you should use AnyObject.
 
 */

// Any will convert as swift type

// converting plain string to any will give String as output
print(type(of: ("1" as Any)))

// Any will also used to convert (class type of NSPointerString)
print(type(of: (("1" as AnyObject) as Any)))

// converting plain string to AnyObject will give NSString as output
print(type(of: ("1" as AnyObject)))

var value: [Any] = ["2", 1, ["1": "1"], ["1", "1"]]

for i in value {
    switch i {
    case is Int:
        print("\(i) is Int")
    case is String:
        print("\(i) is String")
    default:
        print("\(i) is \(type(of: i))")
    }
}
