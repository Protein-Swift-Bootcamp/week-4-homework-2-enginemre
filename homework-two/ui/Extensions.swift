//
//  Extensions.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 31.12.2022.
//


import UIKit

extension UIViewController {
    
    
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        
        // Creating activity indicator
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height:100))
        // Changing background color of view
        spinner.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.medium;
        // Centering activity indicator in the created view
        spinner.center = view.center
        // Adding created view to parent view
        view.addSubview(spinner)
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
        
        return spinner
    }
    
}

extension UIActivityIndicatorView {
    func dismissLoader(view:UIView) {
        self.stopAnimating()
        view.isUserInteractionEnabled = true
        
    }
}
