//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
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
        setupUI()
    }
    
    private func setupUI() {
        //movieMinLabel.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
    }
    
    
    public func configure(with movie: MovieDetail) {
        movieMinLabel.text = movie.min
        movieYearLabel.text = movie.year
        movieLanguageLabel.text = movie.language
        movieRatingLabel.text = movie.ratings[0].value
        plotExplanationLabel.text = movie.plot
        directorExplanationLabel.text = movie.director
        writerExplanationLabel.text = movie.writer
        actorsExplanationLabel.text = movie.actors
        countryExplanationLabel.text = movie.country
        boxofficeExplanationLabel.text = movie.boxOffice
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
 }


    
    @IBAction func addFavoritesButtonTapped(_ sender: Any) {
    }
    
    
}
