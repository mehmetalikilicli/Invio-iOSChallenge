//
//  LoadingAnimation.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 29.11.2022.
//

import Foundation
import UIKit


///Loading Animations
class LoadingAnimation {
    
    static func loadingAnimation(xCoordinate : Int, yCoordinate : Int, width : Int, height: Int) -> UIView {
        let view = UIView(frame: CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height))
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        spinner.startAnimating()
        return view
    }
}
