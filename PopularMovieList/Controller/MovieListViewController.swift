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
    private let listView = MovieListView()
    private let activityIndicator = UIActivityIndicatorView()
    
    //MARK: - View Model
    private var viewModel:MovieListViewModel = MovieListViewModel()
    
    
    //MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()

    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.style = .medium
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
    

    
 
    }
    
    


    


    
    
    



