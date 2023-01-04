//
//  DetailViewController.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit
import Kingfisher
class DetailViewController: UIViewController {
    
    var id : Int? = nil
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var species: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id {
            fetchCharacterDetail(id: id)
        }
    }
    
    // MARK: Fetching Rick and Morty character
    private func fetchCharacterDetail(id: Int){
        let indic = self.showLoader(view: self.view)
        if let url = URL(string: "https://rickandmortyapi.com/api/character" + "/\(id)"){
            // request configration
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                // error exist
                if  error != nil  {
                    DispatchQueue.main.async {
                        indic.dismissLoader(view:self.view)
                    }
                    print("error")
                    return
                }
                // data exist
                if let data = data {
                    do{
                        // Decoding http response to our model
                        let character = try JSONDecoder().decode(Result.self, from: data )
                        // Setting image according to status
                        let newImg: UIImage?
                        if (character.status!.starts(with: "A")){
                            newImg = UIImage(named: "check")
                        }
                        else if (character.status!.starts(with: "D")){
                            newImg = UIImage(named: "poison")
                        }
                        else{
                            newImg = UIImage(named: "info")
                        }
                        // Main thread operation
                        DispatchQueue.main.async {
                            // Setting detail screen component
                            self.statusImage.image = newImg
                            self.characterName.text = character.name
                            if let image = character.image {
                                self.characterImage.kf.setImage(with: URL(string:image ))
                            }
                            self.status.text = character.status ?? "Empty"
                            self.species.text = character.species ?? "Empty"
                            indic.dismissLoader(view:self.view)
                        }
                        
                    }catch{
                        DispatchQueue.main.async {
                            indic.dismissLoader(view:self.view)
                        }
                        print("Decode Olurken hata oluştu")
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    
    
    
}

