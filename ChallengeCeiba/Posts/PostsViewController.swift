//
//  PostsViewController.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 29/09/2022.
//

import UIKit
import CoreData

struct PostInformationUser {
    let postsdUser : [NSManagedObject]
    let name: String
    let email: String
    let telephone: String
}

class PostsViewController: UIViewController {
        
    private var colorPrimary = UIColor(named: "primary-color")
    
    private var postInformationUser: PostInformationUser

    lazy private var nameContactLabel: UILabel = {
        let label = UILabel()
        label.textColor = colorPrimary
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = postInformationUser.name
        return label
    }()
    
    lazy private var titlePosts: UILabel = {
        let label = UILabel()
        label.textColor = colorPrimary
        label.text = "Publicaciones: "
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    lazy private var numberContactLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = postInformationUser.telephone
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var numberContactImageView: UIImageView = {
        let image = UIImage(named: "ic-telephone")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy private var containerContactStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(numberContactImageView)
        stackView.addArrangedSubview(numberContactLabel)
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy private var emailContactLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = postInformationUser.email
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var emailContactImageView: UIImageView = {
        let image = UIImage(named: "ic-email")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy private var containerEmailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(emailContactImageView)
        stackView.addArrangedSubview(emailContactLabel)
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy private var containerInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(nameContactLabel)
        stackView.addArrangedSubview(containerContactStackView)
        stackView.addArrangedSubview(containerEmailStackView)
        stackView.addArrangedSubview(titlePosts)
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    lazy private var postListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostsUserTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    init (postInformationUser: PostInformationUser) {
        self.postInformationUser = postInformationUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        builHierarchy()
        setupConstraints()
    }

    private func builHierarchy() {
        postListTableView.reloadData()
        view.addSubview(containerInformationStackView)
        view.addSubview(postListTableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerInformationStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            containerInformationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerInformationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:16),
            
            numberContactImageView.widthAnchor.constraint(equalToConstant: 16),
            numberContactImageView.heightAnchor.constraint(equalToConstant: 16),

            emailContactImageView.widthAnchor.constraint(equalToConstant: 17),
            emailContactImageView.heightAnchor.constraint(equalToConstant: 16),

            postListTableView.topAnchor.constraint(equalTo: containerInformationStackView.bottomAnchor, constant: 24),
            postListTableView.leadingAnchor.constraint(equalTo: containerInformationStackView.leadingAnchor),
            postListTableView.trailingAnchor.constraint(equalTo: containerInformationStackView.trailingAnchor),
            
            postListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
}

extension PostsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postInformationUser.postsdUser.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostsUserTableViewCell

        let post = postInformationUser.postsdUser[indexPath.row]

        let title =  post.value(forKeyPath: "title") as! String
        let body = post.value(forKeyPath: "body") as! String
        cell.selectionStyle = .none
        cell.updatedInformationCell(title: title, body: body)
        return cell
    }

}
