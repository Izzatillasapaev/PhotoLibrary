//
//  PhotosEndPoint.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 02.02.2020.
//  Copyright © 2020 User. All rights reserved.
//
import Foundation


enum NetworkEnvironment {
    case production
}

public enum GooglePhotosApi {
    case albums(nextPageToken: String?)
    case photos(nextPageToken: String?, albumId: String)
}

extension GooglePhotosApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://photoslibrary.googleapis.com/v1/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: self.environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .albums:
            return "albums/"
        case .photos:
            return "mediaItems:search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .albums:
            return .get
        case .photos:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .albums(let nextPageToken):
            if let pageToken = nextPageToken {
                return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["pageSize":30, "excludeNonAppCreatedData":false, "pageToken":pageToken], additionHeaders: ["Authorization": "Bearer \(NetworkManager.googleToken)"])
            }
            else {
                return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["pageSize":30, "excludeNonAppCreatedData":false], additionHeaders: ["Authorization": "Bearer \(NetworkManager.googleToken)"])
            }
        case .photos(let nextPageToken, let albumId):
            if let pageToken = nextPageToken {
                return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["pageSize":30,  "pageToken":pageToken, "albumId":albumId], additionHeaders: ["Authorization": "Bearer \(NetworkManager.googleToken)"])
            }
            else {
                return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["pageSize":30,  "albumId":albumId], additionHeaders: ["Authorization": "Bearer \(NetworkManager.googleToken)"])
            }
            
        
        }
    }
    
    
    var headers: HTTPHeaders? {
        return ["Authorization": "Bearer \(NetworkManager.googleToken)"]
    }
    
}
// pass: bhg432yui
// photolibrarytest@gmail.com

