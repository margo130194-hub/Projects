//
//  MainViewProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 30/05/2026.
//

import Foundation

protocol MainPresenterProtocol: AnyObject{
    func viewDidLoad()
}

protocol MainViewProtocol: AnyObject{
    func showGreetings(text: String)
    func showDeposit(_ deposits: [Deposit])
    
}
