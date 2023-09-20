//
//  MovieListCollectionViewCell.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 20.09.2023.
//

import UIKit
import SnapKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    static let cellIdentifier = "MovieListCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func addConstraints() {
        imageView.snp.makeConstraints { view in
            view.height.equalTo(50)
            view.top.equalTo(contentView.snp.bottom).offset(20)
            view.left.equalTo(contentView.snp.left).offset(20)
        }
        
        nameLabel.snp.makeConstraints { view in
            view.height.equalTo(50)
            view.left.equalTo(imageView.snp.left)
            view.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        imageView.backgroundColor = .green
        nameLabel.backgroundColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    
    
}

