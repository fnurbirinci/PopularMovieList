//
//  MovieListCollectionViewViewModel.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 22.09.2023.
//

import Foundation

class MovieListCollectionViewViewModel {
    
    var id: Int
    var title: String
    var imageUrl: URL?
    
     init(movie: Movies) {
        self.id = movie.id
        self.title = movie.title ?? ""
        self.imageUrl = generateImageURL(movie.posterPath ?? "")
    }
    
    private func generateImageURL( _ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.shared.imageURL)\(imageCode)")
    }
}
