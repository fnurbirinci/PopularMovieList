//
//  MovieDetailsViewController.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 25.09.2023.
//

import UIKit
import SDWebImage

final class MovieDetailsViewController: UIViewController {
    
    
    //MARK: - Properties
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var dateLabel = UILabel()
    private var voteCountLabel = UILabel()
    private var detailLabel = UILabel()
    
    
    //MARK: - View Model
    var viewModel:MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getMovieDetail()
    }
    
    //MARK: - Methods
    func configureView() {
        self.view.backgroundColor  = .white
        self.title = "Movie Detail"
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 30, y: 30, width: 130, height: 200)
        imageView.snp.makeConstraints { view in
            view.centerY.equalToSuperview().offset(-200)
            view.centerX.equalToSuperview()
            view.height.equalTo(240)
            view.width.equalTo(180)
        }
        
        view.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        titleLabel.snp.makeConstraints { view in
            view.top.equalTo(imageView.snp.bottom).offset(10)
            view.centerX.equalTo(imageView)
            view.height.equalTo(30)
        }
        
        view.addSubview(dateLabel)
        dateLabel.font = .systemFont(ofSize: 15, weight: .regular)
        dateLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(5)
            view.centerX.equalTo(titleLabel)
            view.height.equalTo(20)
        }
        
        view.addSubview(detailLabel)
        detailLabel.font = .systemFont(ofSize: 16, weight: .regular)
        detailLabel.numberOfLines = 0
        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.sizeToFit()
        detailLabel.textAlignment = .left
        detailLabel.lineBreakMode = .byTruncatingMiddle
        detailLabel.snp.makeConstraints { view in
            view.top.equalTo(dateLabel.snp.bottom).offset(30)
            view.centerX.equalToSuperview()
            view.width.equalTo(300)
            
        }
        
        view.addSubview(voteCountLabel)
        voteCountLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        voteCountLabel.snp.makeConstraints { view in
            view.top.equalTo(detailLabel.snp.bottom).offset(50)
            view.left.equalToSuperview().offset(50)
            view.height.equalTo(30)
        }
        
    }
    
    func getMovieDetail() {
        titleLabel.text = viewModel.movieTitle
        dateLabel.text = viewModel.movieDate
        voteCountLabel.text = "Vote Count: \(viewModel.movieVote)"
        imageView.sd_setImage(with: viewModel.movieImage)
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        detailLabel.text = "Overview\n\n\(viewModel.movieOverview)"
        
    }
    
    
}

