//
//  Alert.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 29.11.2022.
//

import Foundation
import UIKit

class Alert {

    static func alert(title: String, description: String? = nil, from: UIViewController) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(dismissAction)
        from.present(alert, animated: true, completion: nil)
    }

}
