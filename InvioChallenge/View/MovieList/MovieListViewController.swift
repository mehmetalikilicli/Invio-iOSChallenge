//
//  MovieListViewController.swift
//  InvioChallenge
//
//  Created by invio on 12.11.2022.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    @IBOutlet weak var topContentView: UIView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MovieListViewModel!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            assertionFailure("Lütfen viewModel'ı inject ederek devam et!")
        }
        
        setupView()
        setupTableView()
        addObservationListener()
        viewModel.start()
    }
    
    func inject(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupView() {
        topContentView.roundBottomCorners(radius: 20)
        searchContainerView.cornerRadius = 10
        searchField.font = .avenir(.Book, size: 16)
        searchField.textColor = .softBlack
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: MovieListTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
        tableView.separatorStyle = .none
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
    }
}


// MARK: - TableView Delegate & DataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = viewModel.getMovieForCell(at: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.className, for: indexPath) as! MovieListTableViewCell
        cell.setupCell(movie: movie)
        return cell
    }
}


// MARK: - ViewModel Listener
extension MovieListViewController {
    func addObservationListener() {
        self.viewModel.stateClosure = { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleClosureData(data: data)
            case .failure(_):
                break
            }
        }
    }
    
    private func handleClosureData(data: MovieListViewModelImpl.ViewInteractivity) {
        switch data {
        case .updateMovieList:
            self.tableView.reloadData()
        }
    }
}
