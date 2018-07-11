//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Zachary Frew on 7/11/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    // MARK: - Life Cycle Methods

    
    // MARK: - Outlets
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonCellTapped(self)
    }
    
    // MARK: - Properties
    var delegate: ButtonTableViewCellDelegate?
    
    // MARK: - Methods
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            completeButton.setImage(UIImage(named: "complete"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
}

// MARK: - Extensions
extension ButtonTableViewCell {
    
    // MARK: - Methods
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
    
}

// MARK: - Protocol
protocol ButtonTableViewCellDelegate {
    func buttonCellTapped(_ sender: ButtonTableViewCell)
}
