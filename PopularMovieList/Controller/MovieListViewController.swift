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
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 80
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    //MARK: - View Model
    private var viewModel:MovieListViewModel = MovieListViewModel()
    
    
    //MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        reloadCollectionView()
        configActivityIndicator()
        bindViewModel()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    
    //MARK: - Methods
    private func configure() {
        view.addSubview(titleLabel)
        titleLabel.text = "Popular Movie List"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(80)
            view.centerX.equalToSuperview()
        }
        

        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(20)
            view.left.right.equalToSuperview().inset(25)
            view.height.equalToSuperview()
        }
    }
    
    private func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    
    
    func configActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.style = .large
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
            return CGSize(width: (view.frame.size.width/3)-2, height: (view.frame.size.height/4)-2)
        }
        

        
    
    }
