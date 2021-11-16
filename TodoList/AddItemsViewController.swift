//
//  AddItemsViewController.swift
//  TodoList
//
//  Created by Basma Alqethami on 08/03/1443 AH.
//

import UIKit
import CoreData


protocol SaveButton: class {
    func SaveButton(title: String, note: String, date: Date? )
}

class AddItemsViewController: UIViewController {

    @IBOutlet weak var Tit: UITextField!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var Date: UIDatePicker!
    
    var dateStr = ""
    weak var delegate: SaveButton?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddItems(_ sender: UIButton) {
        let t = Tit.text!
        let n = note.text!
        let d = Date.date as Date?

        self.delegate?.SaveButton(title: t,note: n,date: d)
        dismiss(animated: true, completion: nil)
    }
    
}
