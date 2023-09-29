//
//  MovieListService.swift
//  PopularMovieList
//
//  Created by Fatmanur Birinci on 15.08.2023.
//

import Foundation


final class NetworkConstant {
    
    //MARK: Properties
    static var shared = NetworkConstant()
    
    
    private init() {
        //Singleton
    }
    
    
    public var apiKey:String {
        get {
            return "dd0d327531bed5fea9734ae8a4db4cb9"
        }
    }
    
    
    public var serverAdress:String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageURL: String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
}

