//
//  KeyboardViewController.swift
//  futhark keyboard
//
//  Created by Andrey Skurlatov on 25.1.24..
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    let runes: [String] = ["ᚠ", "ᚢ", "ᚦ", "ᚨ", "ᚱ", "ᚲ", "ᚷ", "ᚹ", "ᚺ", "ᚾ", "ᛁ", "ᛃ", "ᛇ", "ᛈ", "ᛉ", "ᛊ", "ᛏ", "ᛒ", "ᛖ", "ᛗ", "ᛚ", "ᛜ", "ᛞ", "ᛟ"]
    
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
            
            rowStackView.heightAnchor.constraint(equalToConstant: standardKeyHeight).isActive = true
            
            mainStackView.addArrangedSubview(rowStackView)
         }
        
        let keyWidthToHeightRatio: CGFloat = 1.2 // Adjust this ratio based on the screenshot
        let standardKeyHeight: CGFloat = 50 // Keep the height you already have or adjust as needed
        let standardKeyWidth = standardKeyHeight * keyWidthToHeightRatio
        
        let keySpacing: CGFloat = 6
        
        let sideButtonsTotalWidth = standardKeyWidth * 4
        let totalSpacing = keySpacing * 5 // 5 gaps between the 6 bottom row elements

        // Subtract the width of the side buttons and spacing from the screen's width
        let availableWidthForSpaceButton = UIScreen.main.bounds.width - sideButtonsTotalWidth - totalSpacing
        
        let deleteButton = createSpecialButton(title: "⌫", width: standardKeyWidth)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        
        let returnButton = createSpecialButton(title: "return", width: standardKeyWidth)
        returnButton.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        
        let spaceButton = createSpecialButton(title: " ", width: availableWidthForSpaceButton)
        spaceButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let bottomRowStackView = UIStackView()
        bottomRowStackView.axis = .horizontal
        bottomRowStackView.alignment = .fill
        bottomRowStackView.distribution = .fill
        bottomRowStackView.spacing = keySpacing
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let globeButton = createKeyboardSwitcherButton()
            bottomRowStackView.addArrangedSubview(globeButton)

        }
        
        let punctuationStackView = createRowStackView(for: punctuations)
        bottomRowStackView.addArrangedSubview(punctuationStackView)
        
        bottomRowStackView.addArrangedSubview(spaceButton)
        bottomRowStackView.addArrangedSubview(deleteButton)
        bottomRowStackView.addArrangedSubview(returnButton)
                
        mainStackView.addArrangedSubview(bottomRowStackView)
        
        updateButtonAppearance()
    }
    
    // Step 1: Create the Keyboard Switcher Button
    private func createKeyboardSwitcherButton() -> UIButton {
        let button = UIButton(type: .system)
        // You can use an image like a globe icon
        button.setImage(UIImage(systemName: "globe"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        button.tintColor = userInterfaceStyle == .dark ? .white : .black
        
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .touchUpInside)
        
        return button
    }

    // Step 2: Handle the Button Tap
    @objc override func handleInputModeList(from view: UIView, with event: UIEvent) {
        self.advanceToNextInputMode()
    }
    
    private func createSpecialButton(title: String, width: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        if width > 0 {
            button.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

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
        
//        stackView.heightAnchor.constraint(equalToConstant: standardKeyHeight).isActive = true
        
        return stackView
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: standardKeyHeight).isActive = true
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        button.addGestureRecognizer(longPressRecognizer)
        
        return button
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            guard let button = gestureRecognizer.view as? UIButton,
                  let rune = button.title(for: .normal),
                  let options = optionsForRune(rune) else { return }
            
            createOptionsView(withOptions: options, relativeToButton: button)
        }
    }
    
    
    private func createOptionsView(withOptions options: [String], relativeToButton button: UIButton) {
        // Remove any existing options view
        self.view.subviews.forEach { if $0.tag == 100 { $0.removeFromSuperview() } }
        
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let optionsView = UIVisualEffectView(effect: blurEffect)
        optionsView.layer.cornerRadius = 10
        optionsView.clipsToBounds = true
        optionsView.translatesAutoresizingMaskIntoConstraints = false
        optionsView.tag = 100 // Tag to identify this view
        
        // Add optionsView to the main view of the keyboard
        self.view.addSubview(optionsView)

        // Set constraints for optionsView
        _ = button.convert(button.bounds, to: self.view)
        
        
        var constraints = [
            optionsView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            optionsView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10), // 10 points above the button
            optionsView.widthAnchor.constraint(equalToConstant: 50), // Adjust width as necessary
            optionsView.heightAnchor.constraint(equalToConstant: CGFloat(options.count * 44)) // Adjust height as necessary
        ]
        
        
        NSLayoutConstraint.activate(constraints)
        self.view.layoutIfNeeded()
        
        // Determine if the optionsView is going out of bounds
        if optionsView.frame.minY < 0 {
            // Deactivate the initial bottom constraint
            NSLayoutConstraint.deactivate(constraints.filter { $0.firstAnchor == optionsView.bottomAnchor })
            
            // Attach the options view below the button instead
            constraints = [
                optionsView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                optionsView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10), // 10 points below the button
                optionsView.widthAnchor.constraint(equalToConstant: 50),
                optionsView.heightAnchor.constraint(equalToConstant: CGFloat(options.count * 44))
            ]
            
            NSLayoutConstraint.activate(constraints)
        }

        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        optionsView.contentView.addSubview(stackView)
        
        // Set constraints for stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: optionsView.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: optionsView.contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: optionsView.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: optionsView.contentView.trailingAnchor)
        ])

        // Add buttons to stackView
        for option in options {
            let userInterfaceStyle = traitCollection.userInterfaceStyle
            let textColor: UIColor
            
            if userInterfaceStyle == .dark {
                textColor = .white // Text color for keys
            } else {
                textColor = .black // Text color for keys
            }
            
            let optionButton = UIButton(type: .system)
            optionButton.setTitle(option, for: .normal)
            optionButton.setTitleColor(textColor, for: .normal)
            optionButton.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(optionButton)
        }
        
        self.view.layoutIfNeeded()
    }


    private func optionsForRune(_ rune: String) -> [String]? {
        // Return different options based on the rune
        // Example:
        switch rune {
        case "ᚲ":
            return ["ᚴ"]
        case "ᚨ":
            return ["ᛡ"]
        case "ᛊ":
            return ["ᛋ"]
        case "ᛉ":
            return ["ᛣ","ᛯ"]
        case "ᛜ":
            return ["ᛝ"]
        default:
            return nil
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        guard let option = sender.title(for: .normal) else { return }

        // Remove the options view
        removeOptionsView()
        
        // Insert the selected text
        insertText(option)
        
        // Optionally, you can remove all options views if there are multiple
        self.view.subviews.forEach { subview in
            if subview.tag == 100 { // the tag you assigned to your options view
                subview.removeFromSuperview()
            }
        }
    }
    
    private func insertText(_ text: String) {
        (textDocumentProxy as UIKeyInput).insertText(text)
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
    
    private func removeOptionsView() {
        self.view.subviews.forEach { subview in
            if subview.tag == 100 { // the tag you assigned to your options view
                subview.removeFromSuperview()
            }
        }
    }
    

    
    @objc func didTapButton(sender: UIButton) {
        // Remove the options view if it's displayed
        removeOptionsView()

        // Insert the character of the tapped button
        if let title = sender.title(for: .normal) {
            let proxy = textDocumentProxy as UIKeyInput
            proxy.insertText(title)
        }
    }

    @objc func didTapDeleteButton() {
        removeOptionsView()
        
        textDocumentProxy.deleteBackward()
    }

    @objc func didTapReturnButton() {
        removeOptionsView()
        
        textDocumentProxy.insertText("\n")
    }
}
