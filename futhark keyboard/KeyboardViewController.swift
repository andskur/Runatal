//
//  KeyboardViewController.swift
//  futhark keyboard
//
//  Created by Andrey Skurlatov on 25.1.24..
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    let runes: [String] = ["ᚠ", "ᚢ", "ᚦ", "ᚨ", "ᚱ", "ᚲ", "ᚷ", "ᚹ", "ᚺ", "ᚾ", "ᛁ", "ᛃ", "ᛇ", "ᛈ", "ᛉ", "ᛊ", "ᛏ", "ᛒ", "ᛖ", "ᛗ", "ᛚ", "ᛜ", "ᛟ", "ᛞ"]
    
    let punctuations: [String] = ["᛫", ":"]
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add custom keyboard initialization code here
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 5
        self.view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        for i in 0..<3 {
            let rowRunes = Array(runes[i*8..<min((i+1)*8, runes.count)])
            let rowStackView = createRowStackView(for: rowRunes)
            mainStackView.addArrangedSubview(rowStackView)
         }
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("⌫", for: .normal)
        deleteButton.setTitleColor(.darkGray, for: .normal)
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 5
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.gray.cgColor
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)

        let returnButton = UIButton(type: .system)
        returnButton.setTitle("↵", for: .normal)
        returnButton.setTitleColor(.darkGray, for: .normal)
        returnButton.backgroundColor = .white
        returnButton.layer.cornerRadius = 5
        returnButton.layer.borderWidth = 1
        returnButton.layer.borderColor = UIColor.gray.cgColor
        returnButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        returnButton.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        
        let spaceButton = UIButton(type: .system)
        spaceButton.setTitle(" ", for: .normal) // no longer hardcoding spaces
        spaceButton.backgroundColor = .white
        spaceButton.layer.cornerRadius = 5
        spaceButton.layer.borderWidth = 1
        spaceButton.layer.borderColor = UIColor.gray.cgColor
        spaceButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)

        let spaceButtonWidthPercent: CGFloat = 0.6 // adjust as needed
        let keyboardWidth = UIScreen.main.bounds.width
        let spaceButtonWidth = keyboardWidth * spaceButtonWidthPercent

        spaceButton.widthAnchor.constraint(equalToConstant: spaceButtonWidth).isActive = true
        spaceButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let bottomRowStackView = UIStackView()
        bottomRowStackView.axis = .horizontal
        bottomRowStackView.alignment = .fill
        bottomRowStackView.distribution = .fill
        bottomRowStackView.spacing = 5
        
        let punctuationStackView = createRowStackView(for: punctuations)
        bottomRowStackView.addArrangedSubview(punctuationStackView)
        
        bottomRowStackView.addArrangedSubview(spaceButton)
        bottomRowStackView.addArrangedSubview(deleteButton)
        bottomRowStackView.addArrangedSubview(returnButton)
        
        mainStackView.addArrangedSubview(bottomRowStackView)
        
        updateButtonAppearance()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Check if the user interface style has changed
        if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            updateButtonAppearance()
        }
    }

    
    func createRowStackView(for items: [String]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        for item in items {
            let button = createButton(title: item)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }

    private func updateButtonAppearance() {
        for view in self.view.subviews {
            if let stackView = view as? UIStackView {
                for subview in stackView.arrangedSubviews {
                    if let button = subview as? UIButton {
                        updateButtonColors(button: button)
                    }
                }
            }
        }
    }

    private func updateButtonColors(button: UIButton) {
        if traitCollection.userInterfaceStyle == .dark {
            // Dark Mode
            button.backgroundColor = UIColor(white: 1, alpha: 0.1)
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor.white.cgColor
        } else {
            // Light Mode
            button.backgroundColor = .white
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @objc func didTapButton(sender: UIButton) {
        let proxy = textDocumentProxy
        proxy.insertText(sender.title(for: .normal) ?? "")
    }
    
    @objc func didTapDeleteButton() {
        textDocumentProxy.deleteBackward()
    }

    @objc func didTapReturnButton() {
        textDocumentProxy.insertText("\n")
    }
    
}
