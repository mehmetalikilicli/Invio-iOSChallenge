//
//  Alert.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 29.11.2022.
//

import Foundation
import UIKit


///Alerts
class Alert {
    
    static func makeAlert(title: String, message: String, from: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        from.present(alert, animated: true, completion: nil)
    }

}
