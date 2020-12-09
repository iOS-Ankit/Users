//
//  UsersWorker.swift
//  UserList
//
//  Created by Ankit Bansal on 07/12/20.
//

import UIKit

class UsersWorker {
  
    func fetchUsers(completionHandler: @escaping (Data?, String?) -> Void) {
        let url = URL(string: "https://randomuser.me/api/?inc=name,email,dob,phone,picture&results=50")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            completionHandler(nil, error.localizedDescription)
          } else {
            completionHandler(data, nil)
          }
        })
        task.resume()
      }
}
