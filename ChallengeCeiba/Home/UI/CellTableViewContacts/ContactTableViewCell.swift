//
//  ContactTableViewCell.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import UIKit
import CoreData

protocol ButtonTouchDelegate {
    func touchButton(_ userId: Int64, _ name: String, _ email: String, _ telephone: String)
}

class ContactTableViewCell: UITableViewCell {

    lazy private var colorPrimary = UIColor(named: "primary-color")

    var delegate: ButtonTouchDelegate?

    var userId: Int64?

    lazy private var nameContactLabel: UILabel = {
        let label = UILabel()
        label.textColor = colorPrimary
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var numberContactLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
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
        stackView.addArrangedSubview(containerButton)
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = false
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.52
        stackView.layer.shadowOffset = CGSize (width: 1, height: 1)
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    lazy private var publicationsButton: UIButton = {
        let button = UIButton()
        button.setTitle("VER PUBLICACIONES", for: .normal)
        button.setTitleColor(colorPrimary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(expandCell), for: .touchUpInside)
        return button
    }()

    lazy private var containerButton: UIStackView = {
        let stackView = UIStackView()
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(publicationsButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        builHierarchy()
        setupConstraints()
    }

    private func builHierarchy() {
        addSubview(containerInformationStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerInformationStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerInformationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerInformationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            numberContactImageView.widthAnchor.constraint(equalToConstant: 16),
            numberContactImageView.heightAnchor.constraint(equalToConstant: 16),

            emailContactImageView.widthAnchor.constraint(equalToConstant: 20),
            emailContactImageView.heightAnchor.constraint(equalToConstant: 16),

            publicationsButton.heightAnchor.constraint(equalToConstant: 45),
            publicationsButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    func updatedInformationCell(name: String, telephone: String, email: String) {
        nameContactLabel.text = name
        emailContactLabel.text = email
        numberContactLabel.text = telephone
    }

    @objc private func expandCell() {
        delegate?.touchButton(userId!, nameContactLabel.text!, emailContactLabel.text!, numberContactLabel.text!)
    }

}

