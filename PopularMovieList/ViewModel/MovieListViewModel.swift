//
//  MovieListViewModel.swift
//  Popular Movie List
//
//  Created by Fatmanur Birinci on 3.09.2023.
//

import Foundation

final class MovieListViewModel {
    
    //MARK: - Properties
    let isLoading: Observable<Bool> = Observable(value: false)
    var cellDataSource: [MovieListCollectionViewViewModel] = []
    var dataSource: PopularMovieModel?
    
    //MARK: - Methods
    func getData(completion: @escaping ((Bool) -> Void)) {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.getPopularMovies() { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let data):
                self?.dataSource = data
                // Update the cellDataSource directly here
                self?.handleMovies(data.results)
                completion(true)
//                self?.cellDataSource.value = data.results.compactMap({ MovieListCollectionViewViewModel(movie: $0) })
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }

    
    func getMoreData(page: Int, completion: @escaping (Bool) -> Void) {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        
        APICaller.getMoreMovies(page: page) { [weak self] result in
            guard let self = self else {
                completion(false) 
                return
            }
            
            self.isLoading.value = false
            
            switch result {
            case .success(let data):
                    self.dataSource = data
                    self.handleMovies(data.results)
                    completion(true)
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func handleMovies(_ movies: [Movies]) {
        for movie in movies {
            let movieModel = Movies(adult: movie.adult,
                                    backdropPath: movie.backdropPath,
                                    genreIDS: movie.genreIDS,
                                    id: movie.id,
                                    originalLanguage: movie.originalLanguage,
                                    originalTitle: movie.originalTitle,
                                    overview: movie.overview,
                                    popularity: movie.popularity,
                                    posterPath: movie.posterPath,
                                    releaseDate: movie.releaseDate,
                                    title: movie.title,
                                    video: movie.video,
                                    voteAverage: movie.voteAverage,
                                    voteCount: movie.voteCount)
            let movieViewModel = MovieListCollectionViewViewModel(movie: movieModel)
            cellDataSource.append(movieViewModel)
        }
    }
    
    func mapCellData() -> [MovieListCollectionViewViewModel] {
        return self.dataSource?.results.compactMap({ MovieListCollectionViewViewModel(movie: $0) }) ?? []
    }

        
    
    func getMovieTitle(_ movie: Movies) -> String {
        return movie.title ?? ""
    }
    
    func getMovie(with id: Int) -> Movies? {
        guard let movie = dataSource?.results.first(where: {$0.id == id})
        else { return nil }
        return movie
        
    }
}

