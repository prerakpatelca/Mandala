//
//  MoodSelectionViewController.swift
//  Mandala
//
//  Created by Prerak Patel on 2020-12-05.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController {

//    @IBOutlet var stackView: UIStackView!
    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    
    // Property Obeserver
    // What is map? = Map method of the array is used to transform one array into another array, think of it as a foreach loop where you can assumes have moods array and you can write "for mood in moods" and then you can use mood variable inside a for loop
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodSelector.images = moods.map { $0.image }
            moodSelector.highlightColors = moods.map { $0.color }
//            moodButtons = moods.map { mood in
//                let moodButton = UIButton()
//                moodButton.setImage(mood.image, for: .normal)
//                moodButton.imageView?.contentMode = .scaleAspectFit
//                moodButton.adjustsImageWhenHighlighted = false
//                moodButton.addTarget(self,
//                                     action: #selector(moodSelectionChanged(_:)),
//                                     for: .touchUpInside)
//                return moodButton
//            }
        }
    }
    
    
    
//    var moodButtons: [UIButton] = [] {
//        didSet {
//            oldValue.forEach { $0.removeFromSuperview() }
//            moodButtons.forEach { stackView.addArrangedSubview($0) }
//        }
//    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
//            addMoodButton?.backgroundColor = currentMood.color
            let selectionAnimation = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.7, animations: {
                    self.addMoodButton?.backgroundColor = currentMood.color
            })
            selectionAnimation.startAnimation()
        }
    }
    
    var moodsConfigurable: MoodsConfigurable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
        
    }

//    @objc func moodSelectionChanged(_ sender: UIButton) {
    @IBAction func moodSelectionChanged(_ sender: ImageSelector) {
//        guard let selectedIndex = moodButtons.firstIndex(of: sender)
//            else {
//                preconditionFailure("Unable to find tapped button in the buttons array.")
//        }
        
        let selectedIndex = sender.selectedIndex
        
        currentMood = moods[selectedIndex]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable
                else {
                    preconditionFailure("View controller expected to conform to MoodsConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood
            else {
                return;
        }
        let newMoodEntry = MoodEntry(mood: currentMood, timeStamp: Date())
        moodsConfigurable.add(newMoodEntry)
    }
}

