//
//  CustomTabBarVC.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import Foundation
import UIKit

class CustomTabBarVC: UITabBarController, UITabBarControllerDelegate {
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 0
        setupMiddleButton()
    }
    
    func setupMiddleButton() {
        
    }
}
