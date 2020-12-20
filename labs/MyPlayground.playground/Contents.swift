import UIKit

//func addTwoValue(a: Double,b: Double) -> Double{
//  return a + b
//}
//
//func dosomethinAfterGetData(localData: Double,  command: (Double,Double)->(Double)  )->Double{
//
//  let dataResult = 12.0
//  // takes 1 day
//  return command(localData, dataResult)
//}
//
//
//let localData = 24.0
//
//let r = dosomethinAfterGetData(localData: localData, command: {$0+$1})
//print(r)
func isReferenceType(_ toTest: Any) -> Bool {
    return type(of: toTest) is AnyClass
}

func yy(){
  print("123")
}

class A{}
struct B{}

let a = {print("123")}
let b = yy

print(a)


