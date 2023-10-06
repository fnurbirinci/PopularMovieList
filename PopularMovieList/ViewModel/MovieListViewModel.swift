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
    let cellDataSource: Observable<[MovieListCollectionViewViewModel]> = Observable(value: [])
    var dataSource: PopularMovieModel?
    
    //MARK: - Methods
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.getPopularMovies() { [weak self] result in
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
    
    func getMoreData(page: Int) {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.getMoreMovies(page: page) { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let data):
                
                if var dataSource = self?.dataSource {
                    // Append new data to the existing results array
                    dataSource.results.append(contentsOf: data.results)
                    self?.dataSource = dataSource
                    self?.mapCellData()
                }
            case .failure(let error):
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

