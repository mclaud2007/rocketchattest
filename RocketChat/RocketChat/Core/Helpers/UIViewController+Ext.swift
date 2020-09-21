//
//  UIViewController+Ext.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 21.09.2020.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorMessage (message: String){
        let alertVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
