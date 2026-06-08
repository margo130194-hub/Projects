//
//  NetworkService.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/06/2026.
//

import Foundation

struct AtmResponse: Decodable{
    let data: AtmData
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

struct AtmData: Decodable{
    let atm: [ATM]
    
    enum CodingKeys: String, CodingKey {
        case atm = "ATM"
    }
}

struct ATM: Decodable{
    let  currency: String?
    let cards: [String]?
    let currentStatus: String?
    let Address: Address
    let services: [String]?
}

struct Address: Decodable{
    let streetName: String?
    let buildingNumber: String?
    let townName: String
    let Geolocation: Geolocation
}

struct Geolocation: Decodable{
    let GeographicCoordinates: GeographicCoordinates
}

struct GeographicCoordinates: Decodable{
    let latitude: String
    let longitude: String
}

enum NetworkErrorMap: Error, LocalizedError {
    case invalidURL
    case noData
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Wrong URL"
        case .noData:
            return "No data"
        case .httpError(let statusCode):
            return "Error: \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

final class NetworkServiceMap{
    
    static let shared = NetworkServiceMap()
    private let baseURL = "https://belarusbank.by"
    private let session: URLSession
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    func fetchAtmAsync()async throws -> [ATM]{
        guard let url = URL(string: "\(baseURL)/open-banking/v1.0/atms") else {
            throw NetworkErrorMap.invalidURL
        }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkErrorMap.noData
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkErrorMap.httpError(statusCode: httpResponse.statusCode)
            }
            let decoder = JSONDecoder()
            let decodeResult = try decoder.decode(AtmResponse.self, from: data)
            let atmArray = decodeResult.data.atm
            let sortedAtm = atmArray.sorted{$0.Address.streetName ?? $0.Address.townName < $1.Address.streetName ?? $1.Address.townName}
            return sortedAtm
        }
        catch let error as NetworkErrorMap{
            throw error
        } catch {
            throw NetworkErrorMap.networkError(error)
            
        }
    }
}


