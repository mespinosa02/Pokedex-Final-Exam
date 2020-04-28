//
//  PokemonData.swift
//  Pokedex Final Exam
//
//  Created by SBAUser on 4/27/20.
//  Copyright © 2020 Michelle Espinosa. All rights reserved.
//

import Foundation

class PokemonData {
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Pokemon]
    }
    
    var count = 0
    var url = "https://pokeapi.co/api/v2/pokemon/"
    var pokeArray: [Pokemon] = []
    
    
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
                self.count = returned.count
                self.url = returned.next
                self.pokeArray = self.pokeArray + returned.results
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}
