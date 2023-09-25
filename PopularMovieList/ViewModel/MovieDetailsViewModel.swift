//
//  MovieDetailsViewModel.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 25.09.2023.
//

import Foundation

final class MovieDetailViewModel {
    
    var movieTitle: String
    var movieOverview: String
    var movieDate: String
    var movieVote: Int
    var movieImage: URL?
    var movieID: Int
    
    init(movie: Movies) {
        self.movieTitle = movie.title ?? ""
        self.movieOverview = movie.overview ?? ""
        self.movieDate = movie.releaseDate ?? ""
        self.movieVote = movie.voteCount ?? 0
        self.movieID = movie.id
        self.movieImage = generateImageURL(movie.backdropPath ?? "")
    }
    
    private func generateImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.shared.imageURL)\(imageCode)")
    }
    
}
