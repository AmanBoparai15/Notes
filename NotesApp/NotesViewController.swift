//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Amandeep Kaur on 2020-02-03.
//  Copyright © 2020 Amandeep Kaur. All rights reserved.
//

import UIKit

    //the protocol (or delegate) pattern, so we can update the table view's selected item
    protocol NoteViewDelegate {
    //the name of the function that will be implemented
        func didUpdateNoteWithTitle(newTitle : String, andBody newBody : String)
    }
    
    class NotesViewController: UIViewController, UITextViewDelegate {
    
    //a variable to hold the delegate (so we can update the table view)
         var delegate : NoteViewDelegate?

    //a variable to link the Done button
    weak var btnDoneEditing: UIBarButtonItem!
    @IBOutlet weak var txtBody : UITextView!
    
    //a string variable to hold the body text
    var strBodyText : String!
    
    //makes the keyboard appear immediately
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //set the body's text to the intermitent string
        self.txtBody.text = self.strBodyText
         self.txtBody.becomeFirstResponder()
        self.txtBody.delegate = self
    }
    
    @IBAction func doneEditingBody() {
    //hides the keyboard
        self.txtBody.resignFirstResponder()
    
        //makes the button invisible (still allowed to be pressed, but that's okay for this app)
        self.btnDoneEditing.tintColor = UIColor.clear
        
        //tell the main view controller that we're going to update the selected item
        //but only if the delegate is NOT nil if self.delegate != nil {
        self.delegate!.didUpdateNoteWithTitle( newTitle: self.navigationItem.title!, andBody: self.txtBody.text)
        }

        
    func textViewDidBeginEditing(_ textView: UITextView) {
        //sets the color of the Done button to the default blue
        //it's not a pre-defined value like clearColor, so we give it the exact RGB values
        self.btnDoneEditing.tintColor = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //tell the main view controller that we're going to update the selected item
        //but only if the delegate is NOT nil
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle( newTitle: self.navigationItem.title!, andBody: self.txtBody.text)
        }

    }
        
        func textViewDidChange(_ textView: UITextView){
               //separate the body into multiple sections
            let components = self.txtBody.text.components(separatedBy: "\n");
               //reset the title to blank (in case there are no components with valid text)
        self.navigationItem.title = ""
        //loop through each item in the components array (each item is auto-detected as a String)
               for item in components {
        //if the number of letters in the item (AFTER getting rid of extra white space) is greater than 0...
                if item.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
        //then set the title to the item itself, and break out of the for loop
        self.navigationItem.title = item
         break }
        }
            
        }
        
}
 
