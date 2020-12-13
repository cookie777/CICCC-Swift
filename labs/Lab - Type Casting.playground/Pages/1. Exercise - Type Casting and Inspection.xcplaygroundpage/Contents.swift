/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
let anyType : [Any] = [34.5, 54.3 ,7,"Any", true, false]
print(anyType)

/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */
for val in anyType{
  if val is Int{
    print(val)
  }
}

/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
let anyDict : [String: Any] = ["dobules":7.23, "integers":8, "booleans":true, "string": "str", "bool":false]

for (key,val) in anyDict{
  print(key, val)
}

/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */
var total : Double = 0.0
for (key, val) in anyDict{
  if key is 
}

/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */


//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
