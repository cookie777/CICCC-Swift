
import UIKit
//
//class Parent{
//    var v1 : Int = 6
//    var v2 : String = "8ee"
//
////    init(v1: Int, v2: String){
////        self.v1 = v1
////        self.v2 = v2
////    }
//
//    func m1(){
//        print("pm1")
//        print("pm2")
//    }
//
//}
//
//class Child: Parent{
//    var v3: Double
//    init(v3: Double) {
//        self.v3 = v3
////        super.init(v1: 3, v2: "4sd")
//    }
//
//    override func m1() {
////        super.m1()
//        print("cm1")
////        print(super.m1())
//    }
//}
//
////var p = Parent(v1: 5, v2 : "3")
//var c = Child( v3:3.2)
//c.v1
//c.m1()

//print(c.v1)

class Person {
  var name: String =  "aaa"
    
    init() {
        name = "bbbb"
    }

  init(name: String) {
    self.name = name
  }
}

class Student: Person {
  var favoriteSubject: String
    
  init(favoriteSubject: String) {
    self.favoriteSubject = favoriteSubject
//    super.init(name: "")
  }
}

