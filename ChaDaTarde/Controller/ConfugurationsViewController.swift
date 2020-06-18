//
//  ConfugurationsViewController.swift
//  ChaDaTarde
//
//  Created by Jose Joao Silva Nunes Alves on 25/04/20.
//  Copyright © 2020 Jose Joao Silva Nunes Alves. All rights reserved.
//

import UIKit

class ConfugurationsViewController: UIViewController {
    
    weak var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        delegate?.didSetTimer(seconds: 30, name: "bla")
        self.dismiss(animated: true, completion: nil)
    }

}
