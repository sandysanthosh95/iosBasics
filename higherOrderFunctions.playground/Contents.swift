import UIKit


// Highter order function

// Functions that operate on other functions, either by taking them as arguments or by returning them, are called higher-order functions. Since we have already seen that functions are regular values, there is nothing particularly remarkable about the fact that such functions exist.

/*
    Filter
    Sort
    Reduce
    Map
    CompactMap
    FlatMap // deprecated
*/

func filterExample() {
    // Finding even number
    let input = [1,2,3,4,5,6,7,8,9,10]
    
    let filterOutput = input.filter { $0%2 == 0 }
    print(filterOutput)
}

func sortExample() {
    let input = [2,4,3,1,5,9]
    let sortedOutput = input.sorted { $0 < $1}
    print(sortedOutput)
}

func reduceExample() {
    let input = ["s", "a", "n", "d", "y"]
    
    let reduceOutput = input.reduce(into: "My name is ") { partialResult, value in
        return partialResult = partialResult + value
    }
    print(reduceOutput)
}


func mapExample() {
    // convert the data into different data, It will return nil if not possible to convert
    let input = ["1","2","3s","4","5"]
    
    let mapOutput = input.map { Int($0) }
    print("mapOutput:", mapOutput)
}

mapExample()

func compactExample() {
    // convert the data into different data, It unwrap the optional and remove nil in the output array
    let input = ["1","2","3s","4","5"]
    
    let compactOutput = input.compactMap { Int($0) }
    print("compactOutput:", compactOutput)
}

compactExample()

