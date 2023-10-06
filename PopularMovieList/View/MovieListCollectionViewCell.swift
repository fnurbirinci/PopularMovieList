//
//  MovieListCollectionViewCell.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 20.09.2023.
//

import UIKit
import SnapKit
import SDWebImage


final class MovieListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellIdentifier = "MovieListCollectionViewCell"
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        contentView.backgroundColor = .white
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium, width: .standard)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.sizeToFit()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = .clear
        titleLabel.snp.makeConstraints { view in
            view.top.equalTo(contentView.snp.bottom).offset(5)
            view.width.equalTo(150)
            view.centerX.equalTo(contentView)
        }
        
        imageView.snp.makeConstraints { view in
            view.edges.equalTo(contentView)
        }
        
    }
    
    func setupCell(viewmodel: MovieListCollectionViewViewModel) {
        self.titleLabel.text = viewmodel.title
        self.imageView.sd_setImage(with: viewmodel.imageUrl)
        self.imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
    }
}




