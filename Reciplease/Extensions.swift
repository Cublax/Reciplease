//
//  Extensions.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 21/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Delegate
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              self.view.endEditing(true)
          }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           originTextField.resignFirstResponder()
           return true
       }
}
