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
    
    let standardKeyWidth = UIScreen.main.bounds.width / 10 - 6 // 10 keys across, minus margin
    let standardKeyHeight: CGFloat = 50 // Adjust as needed
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 5
        self.view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalPadding: CGFloat = 3 // Adjust this value as needed
        mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalPadding).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalPadding).isActive = true
        
        let topPadding: CGFloat = 5 // Adjust this value to increase the top padding
        mainStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topPadding).isActive = true
        
        let bottomPadding: CGFloat = 5 // Adjust this value to increase the top padding
        mainStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomPadding).isActive = true
        
        
        for i in 0..<3 {
            let rowRunes = Array(runes[i*8..<min((i+1)*8, runes.count)])
            let rowStackView = createRowStackView(for: rowRunes)
            mainStackView.addArrangedSubview(rowStackView)
         }
        
        let keyWidthToHeightRatio: CGFloat = 1.2 // Adjust this ratio based on the screenshot
        let standardKeyHeight: CGFloat = 50 // Keep the height you already have or adjust as needed
        let standardKeyWidth = standardKeyHeight * keyWidthToHeightRatio
        
        let keySpacing: CGFloat = 6
        let numberOfKeysInLastRow = 8 // Adjust this based on your keyboard's last row
        let totalSpacing = keySpacing * CGFloat(numberOfKeysInLastRow - 1) // Total spacing is number of gaps times the spacing between keys
        let totalKeyWidth = standardKeyWidth * CGFloat(numberOfKeysInLastRow) // Total width is the number of keys times the width of each key
        let availableWidthForSpaceButton = UIScreen.main.bounds.width - totalSpacing - totalKeyWidth // Remaining width available for the space button
        
        let deleteButton = createSpecialButton(title: "⌫", width: standardKeyWidth)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        
        let returnButton = createSpecialButton(title: "return", width: standardKeyWidth)
        returnButton.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        
        let spaceButton = createSpecialButton(title: " ", width: availableWidthForSpaceButton)
        spaceButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let bottomRowStackView = UIStackView()
        bottomRowStackView.axis = .horizontal
        bottomRowStackView.alignment = .fill
        bottomRowStackView.distribution = .fillProportionally
        bottomRowStackView.spacing = keySpacing
        
        let punctuationStackView = createRowStackView(for: punctuations)
        bottomRowStackView.addArrangedSubview(punctuationStackView)
        
        bottomRowStackView.addArrangedSubview(spaceButton)
        bottomRowStackView.addArrangedSubview(deleteButton)
        bottomRowStackView.addArrangedSubview(returnButton)
        
        mainStackView.addArrangedSubview(bottomRowStackView)
        
        updateButtonAppearance()
    }
    
    private func createSpecialButton(title: String, width: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        // ... other button setup ...
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        return button
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
        stackView.spacing = 6
        
        for item in items {
            let button = createButton(title: item)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    private func createButton(title: String) -> UIButton {
        let keyWidthToHeightRatio: CGFloat = 1.2 // Adjust this ratio based on the screenshot
        let standardKeyHeight: CGFloat = 50 // Keep the height you already have or adjust as needed
        let standardKeyWidth = standardKeyHeight * keyWidthToHeightRatio
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: standardKeyWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: standardKeyHeight).isActive = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) // This line is important]
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        
        return button
    }


    private func updateButtonAppearance() {
        let buttons = getAllButtonsInView(view: self.view)
        for button in buttons {
            updateButtonColors(button: button)
        }
    }
    
    private func getAllButtonsInView(view: UIView) -> [UIButton] {
        var buttons = [UIButton]()
        for subview in view.subviews {
            if let button = subview as? UIButton {
                buttons.append(button)
            } else if let stackView = subview as? UIStackView {
                buttons.append(contentsOf: getAllButtonsInView(view: stackView))
            }
        }
        return buttons
    }

    private func updateButtonColors(button: UIButton) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        let keyBackgroundColor: UIColor
        let textColor: UIColor
        let borderColor: UIColor
        let borderWidth: CGFloat
        
        if userInterfaceStyle == .dark {
            // Values are chosen to approximate the native keyboard appearance
            keyBackgroundColor = UIColor(white: 0.25, alpha: 1.0) // Dark mode key background
            textColor = .white // Text color for keys
            borderColor = .clear // No border in dark mode
            borderWidth = 0 // No border width
        } else {
            // Adjust these values to match the light mode if necessary
            keyBackgroundColor = UIColor(white: 0.9, alpha: 1.0) // Light mode key background
            textColor = .black // Text color for keys
            borderColor = UIColor(white: 0.8, alpha: 1.0) // Slightly darker border color for keys
            borderWidth = 1 // Border width for keys
        }
        
        button.backgroundColor = keyBackgroundColor
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = 8 // Adjust if needed to match the native keyboard
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
