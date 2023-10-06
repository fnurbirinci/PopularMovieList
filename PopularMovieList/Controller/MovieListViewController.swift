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
    private var collectionView:UICollectionView!
    private var isLoadingData = false
    private var currentPage = 1
    
    //MARK: - View Model
    private var viewModel = MovieListViewModel()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configActivityIndicator()
        bindViewModel()
        if viewModel.cellDataSource.isEmpty {
            viewModel.getData { [weak self] isSuccess in
                guard let self = self else { return}
                if isSuccess {
                    self.reloadCollectionView()
                }
            }
        }
        
    }
    
    
    //MARK: - Methods
    private func configureView() {
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
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


//MARK: - Collection View
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let cellViewModel = self.viewModel.cellDataSource[indexPath.row]
        cell.setupCell(viewmodel: cellViewModel)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.cellDataSource[indexPath.row].title)
        let movieId = viewModel.cellDataSource[indexPath.row].id
        self.openMovieDetail(movieId: movieId)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.cellDataSource.count == 20 * currentPage {
            
            if indexPath.row == viewModel.cellDataSource.count - 1 {
                currentPage += 1
                
                viewModel.getMoreData(page: currentPage) { [weak self] success in
                    self?.fetchDataCompletionHandler(success: success)
                }
            }
        }
    }
    
    
    func fetchDataCompletionHandler(success: Bool) {
            self.isLoadingData = false
            
            if success {
                self.reloadCollectionView()
            }
        }
    }





//func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//    let lastItem = cellDataSource.count - 1
//
//    if indexPath.row == lastItem && !isLoadingData {
//        if let totalPages = dataSource?.totalPages, currentPage < totalPages {
//            // Load more data only if there are more pages to fetch
//            currentPage += 1
//            isLoadingData = true
//
//            viewModel.getMoreData(page: currentPage) { [weak self] success, newData in
//                self?.fetchDataCompletionHandler(success: success, newData: newData)
//            }
//        }
//    }
//}
