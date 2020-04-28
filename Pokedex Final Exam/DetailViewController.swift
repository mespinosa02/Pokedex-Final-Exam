//
//  DetailViewController.swift
//  Pokedex Final Exam
//
//  Created by SBAUser on 4/27/20.
//  Copyright © 2020 Michelle Espinosa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var base_experienceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if pokemon == nil {
            pokemon = Pokemon(name: "", url: "")
        }
        nameLabel.text = pokemon.name
        heightLabel.text = ""
        weightLabel.text = ""
        base_experienceLabel.text = ""
         
       
        let pokeDetail = PokeDetail()
        pokeDetail.url = pokemon.url
        pokeDetail.getData {
            DispatchQueue.main.async {
                self.weightLabel.text = "\(pokeDetail.weight)"
                self.heightLabel.text = "\(pokeDetail.height)"
                self.base_experienceLabel.text = "\(pokeDetail.base_experience)"
                
                guard let url = URL(string: pokeDetail.imageURL) else {
                    self.imageView.image = UIImage(systemName: "person.crop.circle.badge.xmark")
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    self.imageView.image = UIImage(data: data)
                } catch {
                    print("ERROR: thrown trying to get image from URL \(url)")
                }
                
            }
        }
    }
    
}
