//
//  UsersInteractor.swift
//  UserList
//
//  Created by Ankit Bansal on 07/12/20.

import UIKit

protocol UsersBusinessLogic {
    func fetchUserList()
}

protocol UsersDataStore {
}

class UsersInteractor: UsersBusinessLogic, UsersDataStore {
    var presenter: UsersPresentationLogic?
    var worker: UsersWorker?
    
    func fetchUserList() {
        worker = UsersWorker()
        worker?.fetchUsers(completionHandler: { (data, errorString)  in
            if let data = data {
                if let usersList = try? JSONDecoder().decode(Users.UsersList.self, from: data) {
                    self.presenter?.presentUserList(userList: usersList)
                }
            } else {
                self.presenter?.presentUserListError(error: errorString ?? "Something went wrong")
            }
        })
    }
}
