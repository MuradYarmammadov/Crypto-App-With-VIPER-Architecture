//
//  Interactor.swift
//  Viper Architecture
//
//  Created by Murad Yarmamedov on 13.12.23.
//

import Foundation

//Presenter

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getCryptos()
}

class CryproInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchCryptos(with: .failure(.serverError))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidFetchCryptos(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchCryptos(with: .failure(.parsingError))
            }
        }
        task.resume()
    }
}
