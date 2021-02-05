//
//  Movie.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import Foundation

struct Movie {
    var title : String
    var posterURL : String?
    var rating : Double
    var reviewCount : Int
    var genre : [Int]
    
    static var sampleData : [Movie] = [
        Movie(
            title: "Avengers: Infinity War",
            posterURL: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
            rating: 8.3,
            reviewCount: 6937,
            genre: [
                28,
                12,
                14,
                878
            ]
        ),
        Movie(
            title: "Deadpool 2",
            posterURL: "/to0spRl1CMDvyUbOnbb4fTk3VAd.jpg",
            rating: 7.6,
            reviewCount: 3938,
            genre: [
                28,
                35,
                878
              ]
        ),
        Movie(
            title: "Upgrade",
            posterURL: "/adOzdWS35KAo21r9R4BuFCkLer6.jpg",
            rating: 7.6,
            reviewCount: 138,
            genre: [
                28,
                878,
                53
            ]
        ),
        Movie(
            title: "To All the Boys I've Loved Before",
            posterURL: "/hKHZhUbIyUAjcSrqJThFGYIR6kI.jpg",
            rating: 8.4,
            reviewCount: 349,
            genre: [
                35,
                10749
              ]
        ),
        Movie(
            title: "Tag",
            posterURL: "/eXXpuW2xaq5Aen9N5prFlARVIvr.jpg",
            rating: 7,
            reviewCount: 285,
            genre: [
                35,
                18
              ]
        ),
        Movie(
            title: "Disenchantment",
            posterURL: "/c3cUb0b3qHlWaawbLRC9DSsJwEr.jpg",
            rating: 7.8,
            reviewCount: 8,
            genre: [
                16,
                35,
                10765
              ]
        ),
        Movie(
            title: "American Animals",
            posterURL: "/aLbdKxgxuOPvs6CTlmzoOQ4Yg3j.jpg",
            rating:7,
            reviewCount: 38,
            genre: [
                80,
                18
              ]
        ),
        Movie(
            title: "Action Point",
            posterURL: "/5lqJx0uNKrD1cEKgaqF1LBsLAoi.jpg",
            rating: 5.3,
            reviewCount: 31,
            genre: [
                35
              ]
        ),
        Movie(
            title: "Down a Dark Hall",
            posterURL: "/wErHaJrD1QZ2FEVneH6w0GZUz2L.jpg",
            rating:  5.5,
            reviewCount: 30,
            genre:[
                18,
                14,
                27,
                53
              ]
        ),
        Movie(
            title: "Saving Private Ryan",
            posterURL: "/miDoEMlYDJhOCvxlzI0wZqBs9Yt.jpg",
            rating: 8,
            reviewCount: 6840,
            genre: [
                18,
                36,
                10752
              ]
        ),
    ]
}
