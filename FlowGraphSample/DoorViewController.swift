//
//  DoorViewController.swift
//

import UIKit

class DoorViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let door = Door()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.door.isOpenHandler = { [weak self] isOpen in
            self?.updateLabel()
        }
        
        self.updateLabel()
    }
    
    func updateLabel() {
        self.label.text = self.door.isOpen ? "Opened" : "Closed"
    }
    
    @IBAction func open(_ sender: UIButton) {
        self.door.run(.open)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.door.run(.close)
    }
}
