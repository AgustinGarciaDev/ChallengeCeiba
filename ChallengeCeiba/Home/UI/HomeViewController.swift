//
//  ViewController.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    private var listUsers = [NSManagedObject]()
    private var listPosts = [NSManagedObject]()
    private var listsearchUsers = [NSManagedObject]()
    private var filteredData = false

    private var viewModel: HomeViewModel?

    lazy private var flotatingTextField: FlotatingTextField = {
        let textField = FlotatingTextField(placeholderLabel: "Buscar Usuario")
        textField.addBottomBorder()
        textField.addAccesoryTextField()
        textField.addTarget(self, action: #selector(textSearchChange(_:)), for: .editingChanged)
        return textField
    }()

    lazy private var labelSearchResult: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "No se encontro resultado de la busqueda"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    lazy private var contactListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy private var containerTableAndSearchBar: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(flotatingTextField)
        stackView.addArrangedSubview(labelSearchResult)
        stackView.addArrangedSubview(contactListTableView)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        configurationViewController()
        builHierarchy()
        setupConstraints()
    }

    func configurationViewController() {
        let useCase = HomeUseCase(api: RepositoriesAPI())
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        viewModel = HomeViewModel(useCase: useCase, view: self, persistentContainer: persistentContainer)
        viewModel?.getAllUsersCoreData()
        viewModel?.getAllPostsCoreData()
    }

    private func builHierarchy() {
        view.addSubview(containerTableAndSearchBar)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            containerTableAndSearchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            containerTableAndSearchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            containerTableAndSearchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            containerTableAndSearchBar.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
        ])
    }

    @objc private func textSearchChange(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            filterData(query: text)
        } else {
            filteredData = false
            listsearchUsers.removeAll()
            contactListTableView.reloadData()
            labelSearchResult.isHidden = true
        }
    }

    private func filterData(query: String) {
        listsearchUsers.removeAll()

        listUsers.forEach { user in
            let userItem = user.value(forKeyPath: "name") as! String

            if userItem.lowercased().starts(with: query.lowercased()) {
                listsearchUsers.append(user)
            }
        }
        listsearchUsers.isEmpty ? (labelSearchResult.isHidden = false ) :  (labelSearchResult.isHidden = true )
        filteredData = true
        contactListTableView.reloadData()
    }
    
    private func configurationNavBar() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Prueba de ingreso"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary-color")
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if !listsearchUsers.isEmpty {
            return listsearchUsers.count
        }
        return filteredData ? 0 : listUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        if !listsearchUsers.isEmpty {
            let user = listsearchUsers[indexPath.row]
            let name = user.value(forKeyPath: "name") as! String
            let telephone = user.value(forKeyPath: "phone") as! String
            let email = user.value(forKeyPath: "email") as! String
            let id = user.value(forKeyPath: "id") as! Int64
            cell.userId = id
            cell.updatedInformationCell(name: name, telephone: telephone, email: email)
        } else {
            let user = listUsers[indexPath.row]
            let name = user.value(forKeyPath: "name") as! String
            let telephone = user.value(forKeyPath: "phone") as! String
            let email = user.value(forKeyPath: "email") as! String
            let id = user.value(forKeyPath: "id") as! Int64
            cell.userId = id
            cell.updatedInformationCell(name: name, telephone: telephone, email: email)

        }
        cell.contentView.isUserInteractionEnabled = false
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }

}

extension HomeViewController: HomeViewModelUpdated, ButtonTouchDelegate {
    func touchButton(_ userId: Int64, _ name: String, _ email: String, _ telephone: String) {

        let postedUser = listPosts.filter { post in
            let postIdUser = post.value(forKeyPath: "userId") as! Int64
            return postIdUser == userId
        }

        let informationPost = PostInformationUser(postsdUser: postedUser, name: name, email: email, telephone: telephone)

        let viewController = PostsViewController(postInformationUser: informationPost)

        showSheetController(with: viewController)
    }
    
    func setAllUser(users: [NSManagedObject]) {
        listUsers = users
        listsearchUsers = users
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.contactListTableView.reloadData()
        }
       
    }
    func setAllPosts(posts: [NSManagedObject]) {
        listPosts = posts
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
