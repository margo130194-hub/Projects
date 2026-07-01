//
//  JsonService.swift
//  Pet App
//
//  Created by Margarita Matsonko on 22/06/2026.
//

import Foundation

enum DataError: Error, LocalizedError {
    case noData
    case decodingError(Error)
    case dataError(Error)
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .dataError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

final class JsonService{
    
    static let shared = JsonService()
    private let session: URLSession
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    func fetchData<T:Decodable>(fileName: String) throws -> [T]{
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw DataError.noData
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedArray = try JSONDecoder().decode([T].self, from: data)
            return decodedArray
            
        }
        catch let decodingError as DecodingError{
            throw DataError.decodingError(decodingError)
        }
        catch {
            throw DataError.dataError(error)
        }
    }
    
    
    
    
    
}
