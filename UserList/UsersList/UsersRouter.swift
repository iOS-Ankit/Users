//
//  UsersRouter.swift
//  UserList
//
//  Created by Ankit Bansal on 07/12/20.

import UIKit

@objc protocol UsersRoutingLogic {
}

protocol UsersDataPassing {
  var dataStore: UsersDataStore? { get }
}

class UsersRouter: NSObject, UsersRoutingLogic, UsersDataPassing {
  weak var viewController: UsersViewController?
  var dataStore: UsersDataStore?
  
  
}
