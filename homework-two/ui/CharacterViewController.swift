//
//  CharacterViewController.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit
import Kingfisher
class CharacterViewController: UIViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!

    
    // Setting empty array for table view
    var characters: Array<Result> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        // Custom cell registering
        charactersTableView.register(.init(nibName: "CharactersCell", bundle: nil), forCellReuseIdentifier: "CharacterCellIdentifier")
        fetchCharacters()
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        goCustomBack()
    }
    @objc
    func goCustomBack(){
        self.dismiss(animated: true)
    }
    
    // MARK: Fetching all characters
    private func fetchCharacters() {
        let indic = self.showLoader(view: self.view)
        if let url = URL(string: "https://rickandmortyapi.com/api/character"){
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
                        let character = try JSONDecoder().decode(Character.self, from: data )
                        if let result = character.results {
                            self.characters = result
                            // Main thread operation
                            DispatchQueue.main.async {
                                self.charactersTableView.reloadData()
                                indic.dismissLoader(view:self.view)
                            }
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
extension CharacterViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performing navigate to detail screen with id
        if let id =  characters[indexPath.row].id {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
                detailVC.id = id
                present(detailVC, animated: true)
            }
            
            
        }
    }
    
}




extension CharacterViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Setting custom cell
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: "CharacterCellIdentifier", for: indexPath) as! CharactersCells
        
        cell.characterName.text = characters[indexPath.row].name ?? "Empty"
        // Getting image with KF
        if let image = characters[indexPath.row].image {
            cell.characterImage.kf.setImage(with: URL(string:image ))
        }
        return cell
    }
    
    
}
