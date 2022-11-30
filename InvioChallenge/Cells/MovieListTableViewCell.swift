//
//  MovieListTableViewCell.swift
//  InvioChallenge
//
//  Created by invio on 12.11.2022.
//

import UIKit
import Kingfisher
import CoreData

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieImdbLabel: UILabel!
    
    var movie : Movie?
    var isFavoriteImageSet : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.cornerRadius = 12
    }
    
    func setupCell(movie: Movie) {
        self.movie = movie
        movieNameLabel.text = movie.title
        movieYearLabel.text = movie.year
        movieTypeLabel.text = movie.type
        movieImdbLabel.text = "IMDB ID : \(movie.id)"
        setMovieImage(movie: movie)
        setFavoriteImage(movie: movie)
    }
    
    func setFavoriteImage(movie : Movie) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", movie.id)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let favoriteImdbID = result.value(forKey: "imdbID") as? String {
                    //print(favoriteImdbID)
                    if favoriteImdbID == movie.id {
                        DispatchQueue.main.async {
                            self.likeButton.setImage(UIImage(named: "like-fill"), for: .normal)
                        }
                        isFavoriteImageSet = true
                        do{
                            try context.save()
                        } catch {
                            print("Error")
                        }
                        break
                    }
                }
                isFavoriteImageSet = false
            }
            if !isFavoriteImageSet {
                DispatchQueue.main.async {
                    self.likeButton.setImage(UIImage(named: "like-empty"), for: .normal)
                }
            }
        } catch {
            print("error")
        }
    }
    
    func setMovieImage(movie: Movie) {
        if let url = URL(string: movie.poster!), movie.poster != "N/A"{
            DispatchQueue.main.async {
                self.posterImageView.kf.setImage(with: url)
            }
        } else {
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(named: "placeholder-poster")
            }
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        
        var isfavoriteChanged : Bool = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", movie!.id)

        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let favoriteImdbID = result.value(forKey: "imdbID") as? String {
                    //print(favoriteImdbID)
                    if favoriteImdbID == movie?.id {
                        print("silindi")
                        context.delete(result)
                        isfavoriteChanged = true
                        DispatchQueue.main.async {
                            self.likeButton.setImage(UIImage(named: "like-empty"), for: .normal)
                        }
                        do{
                            try context.save()
                        } catch {
                            print("Error")
                        }
                        break
                    }
                }
                
            }
            if !isfavoriteChanged {
                let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
                favorite.setValue(movie?.id, forKey: "imdbID")
                //print(movie!.id)
                do {
                    try context.save()
                    print("Kaydedildi")
                } catch {
                    print("Kaydedilemedi")
                }
                DispatchQueue.main.async {
                    self.likeButton.setImage(UIImage(named: "like-fill"), for: .normal)
                }
            }
        } catch {
            print("error")
        }
    }
}
