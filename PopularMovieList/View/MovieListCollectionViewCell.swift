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
        contentView.backgroundColor = .blue
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        configure()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium, width: .condensed)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.frame = .zero
        imageView.snp.makeConstraints { view in
            view.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { view in
            view.height.equalTo(50)
            view.width.equalTo(contentView)
            view.left.equalTo(contentView)
            view.top.equalTo(contentView.snp.bottom)
        }
        
        titleLabel.backgroundColor = .clear

    }
    
    func setupCell(viewmodel: MovieListCollectionViewViewModel) {
        self.titleLabel.text = viewmodel.title
        self.imageView.sd_setImage(with: viewmodel.imageUrl)
        
    }
    
    
   
    
    
}

