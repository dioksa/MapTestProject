//
//  ViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topButton: UIButton! {
        didSet {
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.topButton.backgroundColor = .red
                self?.topButton.frame.size.width += 40
                self?.topButton.frame.size.height += 40
            }) { _ in
                UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse], animations: { [weak self] in
                    self?.topButton.frame.origin.y -= 20
                })
            }
        }
    }
    
    @IBOutlet weak var bottomButton: UIButton! {
        didSet {
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.bottomButton.backgroundColor = .red
                self?.bottomButton.frame.size.width -= 40
                self?.bottomButton.frame.size.height -= 40
            }) { _ in
                UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse], animations: { [weak self] in
                    self?.bottomButton.frame.origin.y += 20
                })
            }
        }
    }
    
    @IBAction func topButtonAction(_ sender: UIButton) {
        print("Top button was tapped")
    }
    
    
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        print("Button button was tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
