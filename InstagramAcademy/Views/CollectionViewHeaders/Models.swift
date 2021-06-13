//
//  Models.swift
//  InstagramAcademy
//
//  Created by HieuTong on 5/3/21.
//

import Foundation
public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

enum Gender {
    case male, female, other
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

struct User {
    let username: String
    let name: (first: String, last: String)
    let birthDate: Date
    var profilePhoto: URL
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

///Representing user post
public struct UserPost {
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createDate: Date
    let taggedUsers: [String]
    var owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
