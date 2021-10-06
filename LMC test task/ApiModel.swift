//
//  ApiModel.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 02.10.2021.
//

//Request URL https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=Rdne73gGKdI8uVfPwVt7GSbiQwAz3Pw2

import Foundation

// MARK: - Reviews
struct Reviews:  Hashable, Codable {
    let status: String
    let copyright: String
    let has_more: Bool
    let num_results: Int
    let results: [Result]
}

struct Result: Hashable, Codable {
    let display_title: String
    let mpaa_rating: String
    let critics_pick: Int
    let byline: String
    let headline: String
    let summary_short: String
    let publication_date: String
    let opening_date: String?
    let date_updated: String
    let link: Link
    let multimedia: Multimedia?
}

struct Link: Hashable, Codable {
    let type: String
    let url: String
    let suggested_link_text: String
}

struct Multimedia: Hashable, Codable {
    let type: String
    let src: String
    let height: Int
    let width: Int
}


// MARK: - Critics
struct Critics: Hashable, Codable {
    let status: String
    let copyright: String
    let num_results: Int
    let results: [Result2]
}

struct Result2: Hashable, Codable {
    let display_name: String
    let sort_name: String
//    let status: Status
    let bio: String
    let seo_name: String
    let multimedia: Multimedia2?
}

struct Multimedia2: Hashable, Codable {
    let resource: Resource
}

struct Resource: Hashable, Codable {
    let type: String
    let src: String
    let height: Int
    let width: Int
    let credit: String
}

enum Status: Hashable, Codable {
    case empty
    case fullTime
    case partTime
}

