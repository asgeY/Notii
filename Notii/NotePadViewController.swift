//
//  ViewController.swift
//  Notii
//
//  Created by Asgedom Teklu on 11/7/18.
//  Copyright © 2018 Asgedom Y. All rights reserved.
//

import UIKit

class NotePadViewController: UITableViewController {

    var noteArray = ["fatal error: Index out of range",
                    "How do I add a header based on API information in Javascript"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotPadCell", for: indexPath)
        cell.textLabel?.text = noteArray[indexPath.row]
        return cell
    }
    
    //Mark: - TableView Delegete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        //        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK: Compose new notes
    @IBAction func ComposeButtonPressed(_ sender: UIBarButtonItem) {
        let noteField = UITextField()
        self.noteArray.append(noteField.text!)
        self.tableView.reloadData()
    }
    
}


