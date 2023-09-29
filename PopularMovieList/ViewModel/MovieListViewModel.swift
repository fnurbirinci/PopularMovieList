//
//  MovieListViewModel.swift
//  Popular Movie List
//
//  Created by Fatmanur Birinci on 3.09.2023.
//

import Foundation

final class MovieListViewModel {
    
    var isLoading: Observable<Bool> = Observable(value: false)
    var cellDataSource: Observable<[MovieListCollectionViewViewModel]> = Observable(value: nil)
    var dataSource: PopularMovieModel?
    
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.getPopularMovies { [weak self] result in
            self?.isLoading.value = false
        
            switch result {
            case.success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case.failure(let error):
                print(error)
                
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.results.compactMap({MovieListCollectionViewViewModel(movie: $0)
        })
        
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
