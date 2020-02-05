//
//  ViewController.swift
//  NotesApp
//
//  Created by Amandeep Kaur on 2020-02-03.
//  Copyright © 2020 Amandeep Kaur. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NoteViewDelegate{
    
    
    
    var arrNotes = [[String:String]]()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //read in the saved value. use "as?" to convert "AnyObject" (the type returned by NSUserDefaults) to the array of dictionaries
        //this is in an if-block so no "nil found" errors crash the app
        //this is known as downcasting
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String:String]] {
        //set the instance variable to the newNotes variable
            arrNotes = newNotes
        }
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt  indexPath: IndexPath) -> UITableViewCell {
        
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
        
        //grab the "default cell", using the identifier we set up in the Storyboard
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")!
        
    // set the text to a test value to make sure it's working
       cell.textLabel!.text = arrNotes[indexPath.row]["title"]
        //return the newly-modifed cell
        return cell
    }
    
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier:"showEditorSegue", sender: nil)
               //do nothing at the moment
           }
    
    @IBAction func newNote() {
        
        //new dictionary with 2 keys and test values for both
        let newDict = ["title" : "", "body" : ""]
        
    //add the dictionary to the front (or top) of the array
        arrNotes.insert(newDict, at: 0)
        self.selectedIndex = 0
        
           //reload the table ( refresh the view)
        self.tableView.reloadData()
        saveNotesArray()
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //grab the view controller we're gong to transition to
        let notesEditorVC = segue.destination as! NotesViewController
        
        //set the title of the navigation bar to the selectedIndex's title
        notesEditorVC.navigationItem.title = arrNotes[self.selectedIndex]["title"]
        
          //set the body of the view controller to the selectedIndex's body
        notesEditorVC.strBodyText = arrNotes[self.selectedIndex]["body"]
        notesEditorVC.delegate = self
        }

    func didUpdateNoteWithTitle(newTitle: String, andBody newBody: String) {
    //update the respective values
        self.arrNotes[self.selectedIndex]["title"] = newTitle; self.arrNotes[self.selectedIndex]["body"] = newBody
          
        //refresh the view
    self.tableView.reloadData()
        saveNotesArray()
    }

       func saveNotesArray() {
    //save the newly updated array
        UserDefaults.standard.set(arrNotes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
}

