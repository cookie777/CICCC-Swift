//
//  Movie.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import Foundation

struct Movie: Hashable {
    
    
    var id : Int
    var title : String
    var posterURL : String?
    var rating : Double
    var reviewCount : Int
    var genre : [Int]

}

