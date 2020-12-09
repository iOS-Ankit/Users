//
//  UsersViewController.swift
//  UserList
//
//  Created by Ankit Bansal on 07/12/20.
//

import UIKit

protocol UsersDisplayLogic: class {
    
    func displayUsersList(userList: [Users.UserInfo])
    func displayUserListError(error: String)
}

class UsersViewController: UIViewController, UsersDisplayLogic {
    var interactor: UsersBusinessLogic?
    var router: (NSObjectProtocol & UsersRoutingLogic & UsersDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = UsersInteractor()
        let presenter = UsersPresenter()
        let router = UsersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Interface Builder Outlets
    
    @IBOutlet weak var usersListTblVw: UITableView!
    @IBOutlet weak var sortOptionBtn: UIBarButtonItem!
    @IBOutlet weak var sortOptionVw: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Interface Builder Properties
    
    var usersList = [Users.UserInfo]()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Helper Functions
    
    func setupUI() {
        activityIndicator.startAnimating()
        sortOptionVw.alpha = 0
        interactor?.fetchUserList()
    }
    
    func animateSortOptions(alpha: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.sortOptionVw.alpha = alpha
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Interface Builder Actions
    
    @IBAction func sortByNameBtnAction(sender: UIButton) {
        usersList = usersList.sorted(by: { (item1, item2) -> Bool in
            return (item1.name?.first ?? "").compare(item2.name?.first ?? "") == ComparisonResult.orderedAscending
        })
        usersListTblVw.reloadData()
        self.animateSortOptions(alpha: 0)
    }
    
    @IBAction func sortByPhoneBtnAction(sender: UIButton) {
        usersList = usersList.sorted(by: { (item1, item2) -> Bool in
            return (item1.phone ?? "").compare(item2.phone ?? "") == ComparisonResult.orderedAscending
        })
        usersListTblVw.reloadData()
        self.animateSortOptions(alpha: 0)
    }
    
    @IBAction func sortByEmailBtnAction(sender: UIButton) {
        usersList = usersList.sorted(by: { (item1, item2) -> Bool in
            return (item1.email ?? "").compare(item2.email ?? "") == ComparisonResult.orderedAscending
        })
        usersListTblVw.reloadData()
        self.animateSortOptions(alpha: 0)
    }
    
    @IBAction func sortByBirthdayBtnAction(sender: UIButton) {
        if usersList.count > 0 {
            usersList = usersList.sorted(by: { $0.dob?.age ?? 0 < $1.dob?.age ?? 0 })
        }
        usersListTblVw.reloadData()
        self.animateSortOptions(alpha: 0)
    }
    
    @IBAction func resetSortBtnAction(sender: UIButton) {
        setupUI()
    }
    
    @IBAction func sortOptionsBarBtnAction(sender: UIBarButtonItem) {
        if sortOptionVw.alpha == 0 {
            self.animateSortOptions(alpha: 1)
        } else {
            self.animateSortOptions(alpha: 0)
        }
    }
    
    // MARK: Display Results
    
    func displayUsersList(userList: [Users.UserInfo]) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.usersList = userList
            self.usersListTblVw.reloadData()
        }
    }
    
    func displayUserListError(error: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListTableViewCell", for: indexPath) as! UsersListTableViewCell
        cell.setCellData(userInfo: usersList[indexPath.row])
        return cell
    }
    
    
}
