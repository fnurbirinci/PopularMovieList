//
//  APICaller.swift
//  Popular Movie List
//
//  Created by Fatmanur Birinci on 17.09.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

    
public class APICaller {
    
    static func getPopularMovies(
        completionHandler: @escaping (_ result: Result<PopularMovieModel, NetworkError>) -> Void)
    {
        
        let url = NetworkConstant.shared.serverAdress + "movie/popular?api_key=" + NetworkConstant.shared.apiKey
        
        guard let url  = URL(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PopularMovieModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getMoreMovies(page: Int,
                              completionHandler: @escaping (_ result: Result<PopularMovieModel, NetworkError>) -> Void)
    {
        
        let url = NetworkConstant.shared.moreData + "\(page)" + NetworkConstant.shared.apiKeyMoreData
        
        print(url)
        guard let url  = URL(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PopularMovieModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
        
        
        
    }
}
