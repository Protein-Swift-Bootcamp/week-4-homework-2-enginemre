//
//  ViewController.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func locationsButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "LocaitionViewController") as? LocationViewController{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    @IBAction func charactersButton(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

