//
//  ViewController.swift
//  Notii
//
//  Created by Asgedom Teklu on 11/7/18.
//  Copyright © 2018 Asgedom Y. All rights reserved.
//

import UIKit

class NotePadViewController: UITableViewController {

    var noteArray = [Note] ()
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Folders.plist")
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadnotes()
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotPadCell", for: indexPath)
        cell.textLabel?.text = noteArray[indexPath.row].title
        
        return cell
    }
    
    //Mark: - TableView Delegete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        //        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK: Compose new notes
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
   
        let alert = UIAlertController(title: "Add a new Folder", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Folder", style: .default) { (action) in
        
        let newNote = Note()
        newNote.title = textField.text!
        self.noteArray.append(newNote)
            
            self.saveItems()
        
        self.tableView.reloadData()
        self.defaults.set(Date(),forKey: "NotesLastOpenByUser")
        _ = self.defaults.object(forKey: "NotesLastOpenByUser")
    }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Folder"
            textField = alertTextField
    }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems()  {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(noteArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error Encoding folder array,\(error)")
        }
        self.tableView.reloadData()
    }

    func loadnotes (){
        if let data = try? Data (contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            noteArray = try decoder.decode([Note].self, from: data)
            } catch {
                print("error Decoding note array,\(error)")
            }
        }
    }
}

