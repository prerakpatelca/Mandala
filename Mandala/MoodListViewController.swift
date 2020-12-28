//
//  MoodListViewController.swift
//  Mandala
//
//  Created by Prerak Patel on 2020-12-06.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class MoodListViewController: UITableViewController {
    
    // Alernative way of writing below code is var moodEntries: [MoodEntry]()
    var moodEntries: [MoodEntry] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        
        
        // Alternative way of formatting the date as opposed to what we have used it in the past which was computed property
        let dateString = DateFormatter.localizedString(from: moodEntry.timeStamp,
                                                       dateStyle: .medium,
                                                       timeStyle: .short)
        
        cell.detailTextLabel?.text = "on \(dateString)"
        
        return cell;
    }
}

extension MoodListViewController: MoodsConfigurable {
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        
        // We are appending the item at the top of the table
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
