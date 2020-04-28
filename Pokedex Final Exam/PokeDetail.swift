//
//  PokeDetail.swift
//  Pokedex Final Exam
//
//  Created by SBAUser on 4/27/20.
//  Copyright © 2020 Michelle Espinosa. All rights reserved.
//

import Foundation

class PokeDetail {
    var height = 0.0
    var weight = 0.0
    var base_experience = 0.0
    var imageURL = ""
    var url = ""
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var base_experience: Double
        var sprites: Sprites
    }
    
    private struct Sprites: Codable {
        var front_default: String
    }
    
    func getData(completed: @escaping ()->()) {
           let urlString = url
           print("We are accessing the url \(urlString)")
           
           
           guard let url = URL(string: urlString) else {
               print("ERROR: Could not create a URL from \(urlString)")
               completed()
               return
           }
           
           
           let session = URLSession.shared
           
           
           let task = session.dataTask(with: url) { (data, respone, error) in
               if let error = error {
                   print("ERROR: \(error.localizedDescription)")
               }
               
               
               
               do {
                   let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.height = returned.height
                self.weight = returned.weight
                self.base_experience = returned.base_experience
                self.imageURL = returned.sprites.front_default
               } catch {
                   print("JSON ERROR: \(error.localizedDescription)")
               }
               completed()
           }
           
           task.resume()
       }
}
