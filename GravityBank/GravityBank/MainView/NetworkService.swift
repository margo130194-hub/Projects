//
//  NetworkService.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 01/05/2026.
//

import Foundation

struct Deposit: Codable{
    let name: String
    let currency: String
    let percent: String
    let minimal: Int
    let depositTerm: String
    
    var cleanCurrency: String{
        let components = currency.components(separatedBy: ",")
        let clean = components.map{
            $0.replacingOccurrences(of: "(&#xe701)", with: "")
                .trimmingCharacters(in: .whitespaces)
        }
        let cleaned = Array(Set(clean)).sorted()
        return cleaned.joined(separator: "/")
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "vklad_name"
        case currency = "vklad_val"
        case percent = "vklad_procent"
        case minimal = "vklad_minimal"
        case depositTerm = "vklad_srok_text"
    }
}

enum NetworkError: Error, LocalizedError {
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

final class NetworkService{
    
    static let shared = NetworkService()
    private let baseURL = "https://belarusbank.by/api"
    private let session: URLSession
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    func fetchDepositAsync()async throws -> [Deposit]{
        guard let url = URL(string: "\(baseURL)/deposits_info") else {
            throw NetworkError.invalidURL
        }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            let decoder = JSONDecoder()
            let depositsDictionary = try decoder.decode([String: Deposit].self, from: data)
            let depositsArray = depositsDictionary.values.sorted { $0.name < $1.name }
            return Array(depositsArray)
        }
        catch let error as NetworkError{
            throw error
        } catch {
            throw NetworkError.networkError(error)
            
        }
    }
}

