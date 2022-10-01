//
//  TextFieldFlotating.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import Foundation
import UIKit

class FlotatingTextField: UITextField {

    private var placeholderLabel: String?
    private var colorPrimary = UIColor(named: "primary-color")
    private lazy var borderView = UIView()

    lazy var floatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init(placeholderLabel: String) {
        self.placeholderLabel = placeholderLabel
        super.init(frame: .zero)
        configurationStyle()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configurationStyle() {
        placeholder = placeholderLabel
        textColor = colorPrimary
        font = UIFont.boldSystemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(addFloatingLabel), for: .editingDidBegin)
        addTarget(self, action: #selector(removeFloatingLabel), for: .editingDidEnd)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func addFloatingLabel() {
        borderView.backgroundColor = colorPrimary
        floatingLabel.textColor = colorPrimary
        floatingLabel.font = UIFont.systemFont(ofSize: 10.0)
        floatingLabel.text = self.placeholderLabel
        floatingLabel.layer.backgroundColor = UIColor.white.cgColor
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingLabel.clipsToBounds = true
        floatingLabel.frame = CGRect(x: 0, y: 0, width: floatingLabel.frame.width + 4, height: floatingLabel.frame.height)
        floatingLabel.textAlignment = .center
        addSubview(self.floatingLabel)
        floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        placeholder = ""

        bringSubviewToFront(subviews.last!)
        setNeedsDisplay()
    }

    @objc func removeFloatingLabel() {
        if text == "" {
            UIView.animate(withDuration: 0.13) {
                self.subviews.forEach { $0.removeFromSuperview() }
                self.setNeedsDisplay()
            }
            self.addBottomBorder()
            placeholder = placeholderLabel
        }
    }

    func addAccesoryTextField() {
        self.inputAccessoryView = dismissKeyboard()
    }

    private func dismissKeyboard() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dismiss))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }

    @objc private func dismiss() {
        self.endEditing(true)
    }

}

extension FlotatingTextField: UITextFieldDelegate {
    func addBottomBorder(height: CGFloat = 1.0) {
        borderView.backgroundColor = colorPrimary
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.tag = 100
        addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                borderView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }


}
