//
//  UsersModels.swift
//  UserList
//
//  Created by Ankit Bansal on 07/12/20.
//

import UIKit

enum Users {
    
    struct UsersList: Codable {
        var results: [UserInfo]?
    }
    
    struct UserInfo: Codable {
        var name: UserName?
        var email: String?
        var dob: UserBirthday?
        var phone: String?
        var picture: UserProfileImage?
    }
    
    struct UserName: Codable {
        var title: String?
        var first: String?
        var last: String?
    }
    
    struct UserBirthday: Codable {
        var date: String?
        var age: Int?
    }
    
    struct UserProfileImage: Codable {
        var large: String?
        var medium: String?
        var thumbnail: String?
    }
}
