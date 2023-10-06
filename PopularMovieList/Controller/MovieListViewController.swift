//
//  MovieListViewController.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 20.09.2023.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {
    
    //MARK: - Properties
    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    private var cellDataSource: [MovieListCollectionViewViewModel] = []
    private var collectionView:UICollectionView!
    private var isLoadingData = false
    private var currentPage = 1
    
    //MARK: - View Model
    private var viewModel = MovieListViewModel()
    
    
    //MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configActivityIndicator()
        bindViewModel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    
    //MARK: - Methods
    private func configure() {
        self.view.backgroundColor = .white
        self.title = "Popular Movie List"
        
        let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.minimumLineSpacing = 80
           collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.backgroundColor = .white
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.cellIdentifier)
           view.addSubview(collectionView)
           
           collectionView.snp.makeConstraints { view in
               view.top.equalToSuperview()
               view.left.right.equalToSuperview().inset(25)
               view.bottom.equalToSuperview()
        }
    }
    
    private func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    
    func configActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        activityIndicator.color = .black
        activityIndicator.center = self.view.center
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self,
                  let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self,
                  let movies = movies else { return }
            
            self.cellDataSource = movies
            self.reloadCollectionView()
        }
    }
    
    func openMovieDetail(movieId: Int) {
        activityIndicator.startAnimating()
        guard let movie = viewModel.getMovie(with: movieId) else {
            return
        }
        let detailsViewModel = MovieDetailViewModel(movie: movie)
        let detailsViewController = MovieDetailsViewController(viewModel: detailsViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
        activityIndicator.stopAnimating()

    }
}


//MARK: - Collection View
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let cellViewModel = self.cellDataSource[indexPath.row]
        cell.setupCell(viewmodel: cellViewModel)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(cellDataSource[indexPath.row].title)
        let movieId = cellDataSource[indexPath.row].id
        self.openMovieDetail(movieId: movieId)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == cellDataSource.count - 1 && !isLoadingData {
            isLoadingData = true
            currentPage += 1
            
            viewModel.getMoreData(page: currentPage)
            self.fetchDataCompletionHandler(success: isLoadingData)
            }
        }
    
    
    func fetchDataCompletionHandler(success: Bool) {
        DispatchQueue.main.async {
            self.isLoadingData = false
            
            if success {
                self.reloadCollectionView()
            } else {
                print("Failed to fetch data for page \(self.currentPage)")
            }
        }
    }
 
  
    
}
