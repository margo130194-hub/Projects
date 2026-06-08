//
//  MainViewPresenter\.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 30/05/2026.
//

import Foundation

final class MainPresenter: MainPresenterProtocol{
    
    weak var view: MainViewProtocol?
    private let networkService = NetworkService.shared
    
    func viewDidLoad() {
        let activeNumber = UserDefaults.standard.string(forKey: "userNumber") ?? " "
        let defaults = UserDefaults.standard
        let specificKey = "userName \(activeNumber)"
        let name = defaults.string(forKey: specificKey) ?? "Гость"
        view?.showGreetings(text: "Привет, \(name)!")
        
        fetchData()
    }
    
    private func fetchData(){
        view?.showDeposit([])
        Task{ [weak self] in
            guard let self else { return }
            await fetchDataAsync()}
    }
    private func fetchDataAsync() async{
        do {
            let fetchedDeposit = try await networkService.fetchDepositAsync()
            
            await MainActor.run {
                view?.showDeposit(fetchedDeposit)
            }
        } catch {
            print("error \(error)")
        }
    }
}
