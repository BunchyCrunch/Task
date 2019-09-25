//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Josh Sparks on 9/25/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
    }
    
    func updateButton(_ isComplete: Bool) {
        
    }
}
