//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by MacBook on 09/11/2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    private  enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): "[🔥] Bad response from URL: \(url)"
            case .unknown : "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleUrlResponse(completion: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished :
            break
        case .failure(let error) :
            print(error)
        }
    }
    
    private static func handleUrlResponse(completion: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = completion.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        
        else {
            print(completion.data.description)
            throw NetworkingError.badURLResponse(url: url)
        }
        return completion.data
    }
}


