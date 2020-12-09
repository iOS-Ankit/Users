//
//  UsersPresenter.swift
//  UserList
//
//  Created by Ankit Bansal on 07/12/20.


import UIKit

protocol UsersPresentationLogic {
    func presentUserList(userList: Users.UsersList)
    func presentUserListError(error: String)
}

class UsersPresenter: UsersPresentationLogic {
    weak var viewController: UsersDisplayLogic?
    
    func presentUserList(userList: Users.UsersList) {
        if let results = userList.results {
            viewController?.displayUsersList(userList: results)
        }
    }
    
    func presentUserListError(error: String) {
        viewController?.displayUserListError(error: error)
    }
}
