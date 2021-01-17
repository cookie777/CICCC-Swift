import UIKit


enum Categories{
  case amusement
  case restaurant
  case clothes
  case park
  case cafe
}

struct Location{
  let id      : String //id from api or UUID
  let category: Categories
  
  let long    : Double
  let lat     : Double
  
  let title   : String
  let imageURL: String
  let address : String
  
  let website : String?
  let rating  : String?
}

/*eg,
 [
   amusement: [location0, location1, location2...] ,
   restaurant: [location0, location1, location2...] ,
    ...
 ]
 */
var locations : [Categories: [Location]]

// eg. [clothes, restaurant, park]
var userOrder: [Categories]


struct Route{
  let startLocationId : String
  let nextLocationId: String //Last location points to the first location.
  
  // time(minutes) cost (by walk) to go the next location.
  // if we can get time by bike or car, we will add more variables here
  let timeToReachByWalk       : Int
  
}

struct Plan{
  let routes    : [Route]
  let totalTimeByWalk : Int
}

var plans : [Plan]
