//
//  PostsUserTableViewCell.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 29/09/2022.
//

import UIKit

class PostsUserTableViewCell: UITableViewCell {

    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    lazy private var bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var containerPostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupView() {
        builHierarchy()
        setupConstraints()
    }

    private func builHierarchy() {
        addSubview(containerPostStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerPostStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerPostStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerPostStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerPostStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    func updatedInformationCell(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }

}
