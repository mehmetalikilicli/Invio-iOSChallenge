//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import UIKit
import Kingfisher
import CoreData

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieMinLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var plotExplanationLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var directorExplanationLabel: UILabel!
    
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var writerExplanationLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var actorsExplanationLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryExplanationLabel: UILabel!
    
    @IBOutlet weak var boxofficeLabel: UILabel!
    @IBOutlet weak var boxofficeExplanationLabel: UILabel!
    
    private var viewModel : MovieDetailViewModel!
    var movieDetail : MovieDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: movieDetail!)
        setUpUI()
        setupNavBar(title: movieDetail?.title, leftIcon: "left-arrow", rightIcon: "like-empty",leftItemAction: #selector(goBack))
    }
    
    @objc func changeFavoriteStatus() {
        
        var isfavoriteChanged : Bool = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", movieDetail!.id)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let favoriteImdbID = result.value(forKey: "imdbID") as? String {
                    //print(favoriteImdbID)
                    if favoriteImdbID == movieDetail?.id {
                        print("silindi")
                        context.delete(result)
                        isfavoriteChanged = true
                        DispatchQueue.main.async {
                            //Rightbutton.image = UIimage(named: "like-empty")
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
                favorite.setValue(movieDetail?.id, forKey: "imdbID")
                //print(movieDetail?.id)
                do {
                    try context.save()
                    print("Kaydedildi")
                } catch {
                    print("Kaydedilemedi")
                }
                DispatchQueue.main.async {
                    //Rightbutton.image = UIimage(named: "like-fill")
                }
            }
        } catch {
            print("error")
        }
    }

}

// Configure Page
extension MovieDetailViewController {
    
    public func configure(with movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        movieMinLabel.text = movieDetail.min
        movieYearLabel.text = movieDetail.year
        movieLanguageLabel.text = movieDetail.language
        //Bazı rating listeleri boş geliyor
        if !movieDetail.ratings.isEmpty {
            movieRatingLabel.text = movieDetail.ratings[0].value
        } else {
            movieRatingLabel.text = "N/A"
        }
        plotExplanationLabel.text = movieDetail.plot
        directorExplanationLabel.text = movieDetail.director
        writerExplanationLabel.text = movieDetail.writer
        actorsExplanationLabel.text = movieDetail.actors
        countryExplanationLabel.text = movieDetail.country
        boxofficeExplanationLabel.text = movieDetail.boxOffice
        
        setMovieImage(movieDetail: movieDetail)
    }
    
    func setMovieImage(movieDetail: MovieDetail) {
        if let url = URL(string: movieDetail.poster), movieDetail.poster != "N/A"{
            DispatchQueue.main.async {
                self.moviePosterImageView.kf.setImage(with: url)
            }
        } else {
            DispatchQueue.main.async {
                self.moviePosterImageView.image = UIImage(named: "placeholder-poster")
            }
        }
    }
    
}

//Setup UI
extension MovieDetailViewController {
    private func setUpUI() {
        movieMinLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        movieYearLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        movieLanguageLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        movieRatingLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        
        durationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        yearLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        languageLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        ratingLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        
        plotLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        directorLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        writerLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        actorsLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        countryLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        boxofficeLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        
        plotExplanationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        directorExplanationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        writerExplanationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        actorsExplanationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        countryExplanationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        boxofficeExplanationLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        
    }
}
