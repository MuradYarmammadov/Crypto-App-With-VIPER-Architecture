//
//  Router.swift
//  Viper Architecture
//
//  Created by Murad Yarmamedov on 13.12.23.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    
    static func start() -> AnyRouter
}

class CryptoRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        
        let router = CryptoRouter()
        var view: AnyView = CryptoViewController()
        var interactor: AnyInteractor = CryproInteractor()
        var presenter: AnyPresenter = CryptoPresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        router.entry = view as? EntryPoint
        
        return router
    }
}
