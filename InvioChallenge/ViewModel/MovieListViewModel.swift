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
    
    ///ViewController' daki tableView'de tıklanan cell'in movie bilgilerini döner.
    /// - Parameter indexPath: Tıklanan movie'nin indexi
    /// - Returns: Movie datası
    func getMovieForTappedCell(at indexpath : IndexPath, completion: @escaping (MovieDetail) -> Void)
    
    ///  Aranan kelimeye göre ilk 10 movie listesini döner
    /// - Parameter searchText: searchField arama metni
    func getMovies(searchText: String, completion: @escaping (Search) -> Void)
    
    /// Lazy Loading için diğer sayfadaki movie listesini döner
    /// - Parameter searchText: searchField arama metni
    func getMoreMovies(searchText : String, completion: @escaping (Search) -> Void)
    
    
}

final class MovieListViewModelImpl: MovieListViewModel {
    
    var moviesList = [Movie]()
    var isPaginating : Bool?
    
    private var nextPage : Int = 2
    private var maxPage : Int = 0
 
    
    var stateClosure: ((Result<ViewInteractivity, Error>) -> ())?
    
    func start() {
        self.stateClosure?(.success(.updateMovieList))
    }
}


/// Movieleri ve paging için diğer sayfaları alan fonksiyonlar
extension MovieListViewModelImpl {
    
    func getMovies (searchText: String, completion: @escaping (Search) -> Void ){
        GetMoviesService.shared.getMoviesByText(searchText: searchText) { response in
            guard let response = response else { return }
            if response.response == "True" {
                DispatchQueue.main.async {
                    //Yeni arama yapıldığında listeyi sıfırlar
                    self.moviesList.removeAll()
                    self.moviesList.append(contentsOf: response.movies!)
                    //Sayfalar 10'ar 10'ar geliyor.
                    //En fazla sayfa, gelen "totalResults" verisinin 10 a bölünüp
                    //1 eklenmesiyle bulunur.
                    self.maxPage = (Int(response.totalResults!)!/10)+1
                    //print(self.maxPage)
                    completion(response)
                    //print(self.moviesList)
                }
            } else {
                print("Girilen kelimeyle film bulunamadi")
            }
        }
    }
    
    func getMoreMovies( searchText: String, completion: @escaping (Search) -> Void) {
        if nextPage <= maxPage {
            GetMoviesService.shared.getMoviesByText(searchText: searchText, nextPage: nextPage) { response in
                guard let response = response else { return }
                DispatchQueue.main.async {
                    self.moviesList.append(contentsOf: response.movies!)
                    //print(self.moviesList.count)
                    completion(response)
                }
            }
            self.isPaginating = false
            nextPage += 1
        } else {
            //print("No other page")
        }
        
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
        let movie = self.moviesList[indexPath.row]
        return movie
    }
    
    func getMovieForTappedCell(at indexpath: IndexPath, completion: @escaping (MovieDetail) -> Void) {
        GetMovieDetailService.shared.getMovieOnTapped(imdbID: moviesList[indexpath.row].id) { movie in
            guard let movie = movie else { return }
            let movieDetailViewModel = movie
            DispatchQueue.main.async {
                completion(movieDetailViewModel)
            }
        }
    }
}
