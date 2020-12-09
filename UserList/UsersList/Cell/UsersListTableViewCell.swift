//
//  UsersListTableViewCell.swift
//  UserList
//
//  Created by MSS on 07/12/20.
//

import UIKit
import Kingfisher

class UsersListTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageVw: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userPhoneNoLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userBirthday: UILabel!
    
    // MARK: Set Cell Data
    
    func setCellData(userInfo: Users.UserInfo) {
        userNameLbl.text = "\(userInfo.name?.first ?? "") \(userInfo.name?.last ?? "")".capitalized
        userPhoneNoLbl.text = userInfo.phone ?? ""
        userEmailLbl.text = userInfo.email ?? ""
        let url = URL(string: userInfo.picture?.medium ?? "")
        userImageVw.kf.setImage(with: url)
        let formattedDate = formatDate(userInfo.dob?.date ?? "", fromFormat: "yyyy-MM-dd'T'HH:mm:ss", toFormat: "dd/MM/yyyy")
        userBirthday.text = formattedDate
    }
    
    // MARK: Format Date
    
    func formatDate(_ date: String, fromFormat: String, toFormat: String) -> String {
        if date != "" {
            if let date = date.split(separator: ".").first {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = fromFormat
                let formattedDate = dateFormatter.date(from: String(date))
                dateFormatter.dateFormat = toFormat
                return dateFormatter.string(from: formattedDate!)
            }
        }
        return ""
    }
}
