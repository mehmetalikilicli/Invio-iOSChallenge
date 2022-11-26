//
//  MovieListViewModel.swift
//  InvioChallenge
//
//  Created by invio on 12.11.2022.
//

import Foundation
import UIKit

protocol MovieListViewModel: BaseViewModel {
    /// ViewModel ' den viewController' a event tetitkler.
    var stateClosure: ((Result<MovieListViewModelImpl.ViewInteractivity, Error>) -> ())? { set get }
    
    /// ViewController' daki tableView'in row sayısını döner.
    /// - Returns: Int
    func getNumberOfRowsInSection() -> Int
    
    /// ViewController' daki tableView için cell datasını döner.
    /// - Parameter indexPath: Görünür cell'in index'i
    /// - Returns: Movie datası
    func getMovieForCell(at indexPath: IndexPath) -> Movie?
    
    func getMovieOnTapped(at indexpath : IndexPath, completion: @escaping (MovieDetail) -> Void)
    
    func getMovies(searchText: String, completion: @escaping ([MovieVM]) -> Void)
    
}

final class MovieListViewModelImpl: MovieListViewModel {
    
    var moviesList = [MovieVM]()
    
    var movieDetail : MovieDetailVM?
    
    func getMovieOnTapped(at indexpath: IndexPath, completion: @escaping (MovieDetail) -> Void) {
        NetworkManager.shared.getMovieOnTapped(imdbID: moviesList[indexpath.row].id) { movie in
            guard let movie = movie else { return }
            let movieDetailViewModel = movie
            DispatchQueue.main.async {
                completion(movieDetailViewModel)
            }
        }
    }
    
    
    func getMovies (searchText: String, completion: @escaping ([MovieVM]) -> Void ){
        
        NetworkManager.shared.getMoviesByText(searchText: searchText) { movies in
            guard let movies = movies else { return }
            let moviesViewModel = movies.map(MovieVM.init)
            DispatchQueue.main.async {
                self.moviesList = moviesViewModel
                completion(moviesViewModel)
                //print(self.moviesList)
            }
        }
    }
    
    var stateClosure: ((Result<ViewInteractivity, Error>) -> ())?
    
    func start() {
        self.stateClosure?(.success(.updateMovieList))
    }
}

// MARK: ViewModel to ViewController interactivity
extension MovieListViewModelImpl {
    enum ViewInteractivity {
        case updateMovieList
    }
}


// MARK: TableView DataSource
extension MovieListViewModelImpl {
    func getNumberOfRowsInSection() -> Int {
        return self.moviesList.count
    }
    
    func getMovieForCell(at indexPath: IndexPath) -> Movie? {
        let movie = self.moviesList[indexPath.row].movie
        return movie
    }
}
