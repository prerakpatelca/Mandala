//
//  ImageSelector.swift
//  Mandala
//
//  Created by Prerak Patel on 2020-12-06.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class ImageSelector: UIControl {
    
    // Closure Property
    private let selectorStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.alignment = .center
        stackview.spacing = 12.0
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    // Property Oberserver or Computed Property it triggers whenever the value is changed
    var selectedIndex = 0 {
        didSet {
            if selectedIndex < 0 {
                selectedIndex = 0
            }
            if selectedIndex >= imageButtons.count {
                selectedIndex = imageButtons.count - 1
            }
            
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
            
            let imageButton = imageButtons[selectedIndex]
            highlightViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
        }
    }
    
    private var imageButtons : [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            imageButtons.forEach { selectorStackView.addArrangedSubview($0) }
        }
    }
    
    var images: [UIImage] = [] {
        didSet {
            imageButtons = images.map { image in
                let imageButton = UIButton()
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(self,
                                      action: #selector(imageButtonTapped(_:)),
                                      for: .touchUpInside)
                return imageButton
            }
            
            selectedIndex = 0
        }
    }
    
    private let highlightView: UIView = {
        let view = UIView()
//        we commented out below code as we were setting the highlight color to the system tint color and we wanted to change that to take value from colors array
//        view.backgroundColor = view.tintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var highlightViewXConstraint: NSLayoutConstraint! {
        didSet {
            oldValue?.isActive = false
            highlightViewXConstraint.isActive = true
        }
    }
    
    var highlightColors: [UIColor] = [] {
        didSet {
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewHierarchy()
    }
    
    private func configureViewHierarchy() {
        addSubview(selectorStackView)
        
        insertSubview(highlightView, belowSubview: selectorStackView)
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor),
            highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            highlightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor)
        ])
    }
    
    @objc private func imageButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("The button and image are not parallel.")
        }
        
//        commented out below code so that we can give animation
//        selectedIndex = buttonIndex
        
        let selectionAnimation = UIViewPropertyAnimator(
            duration: 0.3,
//            curve: .easeInOut,
//            to give spring like animation lesser the damption ration more will be the springiness behavior in animation
            dampingRatio: 0.7,
            animations: {
                self.selectedIndex = buttonIndex
                self.layoutIfNeeded()
        })
        selectionAnimation.startAnimation()
        
        sendActions(for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2.0
    }
    
    private func highlightColor(forIndex index: Int) -> UIColor {
        guard index >= 0 && index < highlightColors.count
            else {
                return UIColor.blue.withAlphaComponent(0.6)
        }
        return highlightColors[index]
    }
}
