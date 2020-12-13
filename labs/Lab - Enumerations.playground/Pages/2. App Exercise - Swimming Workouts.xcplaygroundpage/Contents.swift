

struct SwimmingWorkout{
  var distance : Double
  var time : Double
  var stroke : Stroke

  static var freestyleWorkouts    : [SwimmingWorkout] = []
  static var butterflyWorkouts    : [SwimmingWorkout] = []
  static var backstrokeWorkouts   : [SwimmingWorkout] = []
  static var breaststrokeWorkouts : [SwimmingWorkout] = []

  
  
  func save() {
    switch stroke {
    case .backstroke:
      SwimmingWorkout.backstrokeWorkouts    += [self]
    case .breaststroke:
      SwimmingWorkout.breaststrokeWorkouts  += [self]
    case .freestyle:
      SwimmingWorkout.freestyleWorkouts     += [self]
    case .butterfly:
      SwimmingWorkout.freestyleWorkouts     += [self]
    }
  }
  
  enum Stroke: String {
    case freestyle, butterfly, backstroke, breaststroke
  }
}

/*:
 Allowing `stroke` to be of type `String` isn't very type-safe. Inside the `SwimmingWorkout` struct, create an enum called `Stroke` that has cases for `freestyle`, `butterfly`, `backstroke`, and `breaststroke`. Change the type of `stroke` from `String` to `Stroke`. Create two instances of `SwimmingWorkout` objects.
 */
let sw = SwimmingWorkout(distance: 521.4, time: 1709.23, stroke: .freestyle)


/*:
 Now imagine you want to log swimming workouts separately based on the swimming stroke. You might use arrays as static variables on `SwimmingWorkout` for this. Add four static variables, `freestyleWorkouts`, `butterflyWorkouts`, `backstrokeWorkouts`, and `breaststrokeWorkouts`, to `SwimmingWorkout` above. Each should be of type `[SwimmingWorkout]` and should default to empty arrays.
 */

/*:
 Now add an instance method to `SwimmingWorkout` called `save()` that takes no parameters and has no return value. This method will add its instance to the static array on `SwimmingWorkout` that corresponds to its swimming stroke. Inside `save()` write a switch statement that switches on the instance's `stroke` property, and appends `self` to the proper array. Call save on the two instances of `SwimmingWorkout` that you created above, and then print the array(s) to which they should have been added to see if your `save` method works properly.
 */
let sw1 = SwimmingWorkout(distance: 521.4, time: 1709.23, stroke: .freestyle)
let sw2 = SwimmingWorkout(distance: 23, time: 323423, stroke: .breaststroke)
let sw3 = SwimmingWorkout(distance: 3, time: 123, stroke: .butterfly)
let sw4 = SwimmingWorkout(distance: 3, time: 9870, stroke: .breaststroke)
let sw5 = SwimmingWorkout(distance: 2, time: 999, stroke: .backstroke)
let sw6 = SwimmingWorkout(distance: 11, time: 223, stroke: .freestyle)
sw1.save()
sw2.save()
sw3.save()
sw4.save()
sw5.save()
sw6.save()


//printRecord(SwimmingWorkout.backstrokeWorkouts)
printRecord(SwimmingWorkout.breaststrokeWorkouts)
//printRecord(SwimmingWorkout.butterflyWorkouts)
//printRecord(SwimmingWorkout.freestyleWorkouts)

func printRecord(_ arr: [SwimmingWorkout]){
  for val in arr{
    print(val.distance)
    print(val.stroke.rawValue)
    print(val.time)
  }
}



/*:

 _Copyright © 2018 Apple Inc._

 _Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:_

 _The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software._

 _THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE._
 */
//: [Previous](@previous)  |  page 2 of 2
