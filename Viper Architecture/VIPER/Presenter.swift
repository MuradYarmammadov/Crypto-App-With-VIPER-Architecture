//
//  Presenter.swift
//  Viper Architecture
//
//  Created by Murad Yarmamedov on 13.12.23.
//

import Foundation

//Router
//Interactor
//View

enum NetworkError: Error {
    case serverError
    case parsingError
}

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchCryptos(with result: Result<[Crypto], NetworkError>)
}

class CryptoPresenter: AnyPresenter {
    var router: AnyRouter?
    var view: AnyView?
    var interactor: AnyInteractor? {
        didSet{
            interactor?.getCryptos()
        }
    }
    
    func interactorDidFetchCryptos(with result: Result<[Crypto], NetworkError>) {
        switch result {
        case .success(let crypto):
            view?.update(with: crypto)
        case.failure:
            view?.update(with: "Error")
        }
    }
    
    
}
