import Foundation
import ScriptHelpers

class test: AsyncOperation {
    
    var value: Bool = false
    
    override func execute() {
        guard canExecute() else {
            return
        }
        
        let random = arc4random_uniform(10)
        
        print(random)
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(random), execute: {
            self.value = true
            self.finish()
        })
    }
}

let operationQ = OperationQueue()
operationQ.maxConcurrentOperationCount = 3
for i in 1...10 {
    let tester = test()
    
    let completion = BlockOperation {
        
//        print(tester.value)
        print("item \(i)")
       
    }
    
    completion.addDependency(tester)
    
    operationQ.addOperations([tester, completion], waitUntilFinished: false)
    
}

//operationQ.cancelAllOperations()
operationQ.waitUntilAllOperationsAreFinished()
print("finished")


//
//print("Hello World!")
//let client = MiniNeClient()
//let request = Request()
//
//let group = DispatchGroup()
//
//for i in 1...5 {
//    group.enter()
//    client.send(request: request) { (resukt) in
//        print("finish request \(i)")
//        group.leave()
//    }
//}
//
//
//group.enter()
//DispatchQueue.global().async {
//    print("dawdw")
//
//    group.leave()
//}
//
////        group.enter()
////        DispatchQueue.main.async {
////            print("ddawdwadawd")
////
////            group.leave()
////        }
//
////        group.notify(queue: .main) {
////            print("Both functions complete 👍")
////        }
////
//group.wait()
////        dispatchMain()
//
//print("finish")
