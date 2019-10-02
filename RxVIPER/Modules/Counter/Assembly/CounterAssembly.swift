//
//  CounterAssembly.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 29.09.2019.

//

import UIKit

class CounterAssembly {

    class func assembleCounter() -> UIViewController {
        let view = CounterViewController(nibName: nil, bundle: nil)
        let presenter = CounterPresenter()
        let interactor = CounterInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor

        return view
    }
}
