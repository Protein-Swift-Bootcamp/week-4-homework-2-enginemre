//
//  LocationDetailViewController.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    var id :Int? = nil
    @IBOutlet weak var locationType: UILabel!
    var location : LocationResult? = nil
    @IBOutlet weak var locationName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let resultId = id{
            fetchLocationDetail(id:resultId)
        }
    }
    

    private func fetchLocationDetail(id:Int){
        let indic = self.showLoader(view: self.view)
        if let url = URL(string: "https://rickandmortyapi.com/api/location" + "/\(id)"){
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
                        let location = try JSONDecoder().decode(LocationResult.self, from: data )
                        // Main thread operation
                        DispatchQueue.main.async {
                            // Setting detail screen component
                            self.locationName.text = location.name
                            self.locationType.text = location.type
                            self.location = location
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


