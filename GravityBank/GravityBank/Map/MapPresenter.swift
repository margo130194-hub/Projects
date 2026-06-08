//
//  MapPresenter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/06/2026.
//

import Foundation

final class MapPresenter: MapPresenterProtocol{
    
    weak var view: MapViewProtocol?
    private let networkService = NetworkServiceMap.shared
    private var atm:[ATM] = []
    
    func viewDidLoad() {
        fetchData()
    }
    
    func fetchData(){
        view?.showAtm([])
        Task{ [weak self] in
            guard let self else { return }
            await fetchDataAsync()}
    }
    private func fetchDataAsync() async{
        do {
            let fetchedatm = try await networkService.fetchAtmAsync()
            self.atm = fetchedatm
            var pins:[AtmAnnotation] = []
            for item in fetchedatm {
                if let long = Double(item.Address.Geolocation.GeographicCoordinates.longitude),
                   let lat = Double(item.Address.Geolocation.GeographicCoordinates.latitude){
                    let annotation = AtmAnnotation(atm: item, latitude: lat, longitude: long)
                    pins.append(annotation)
                }
            }
            await MainActor.run {
                view?.showAtm(pins)
            }
        } catch {
            print("error \(error)")
        }
    }
}

