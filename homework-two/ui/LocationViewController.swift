//
//  LocaitionViewController.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit

class LocationViewController: UIViewController {
    
    var locations : Array<LocationResult> = []

    @IBOutlet weak var locationsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        // Custom cell registering
        locationsTableView.register(.init(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCellIdentifier")
        fetchAllLocation()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func fetchAllLocation(){
        let indic = self.showLoader(view: self.view)
        if let url = URL(string: "https://rickandmortyapi.com/api/location"){
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
                        let locations = try JSONDecoder().decode(LocationDto.self, from: data )
                        if let result = locations.results {
                            self.locations = result
                            // Main thread operation
                            DispatchQueue.main.async {
                                self.locationsTableView.reloadData()
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


extension LocationViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performing navigate to detail screen with id
        if let id =  locations[indexPath.row].id {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyBoard.instantiateViewController(withIdentifier: "LocationDetailViewController") as?
            LocationDetailViewController {
                detailVC.id = id
                present(detailVC, animated: true)
            }
            
            
        }
    }
    
}




extension LocationViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Setting custom cell
        let cell = locationsTableView.dequeueReusableCell(withIdentifier: "LocationCellIdentifier", for: indexPath) as! LocationCell
        let item = locations[indexPath.row]
        cell.name.text  = item.name ?? "Empty"
        cell.locationType.text = item.type ?? "Empty"
        return cell
    }
    
    
}

