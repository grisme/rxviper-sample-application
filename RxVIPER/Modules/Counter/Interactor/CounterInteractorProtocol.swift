//
//  CounterInteractorProtocol.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 02.10.2019.

//

import Foundation
import RxSwift

protocol CounterInteractorProtocol: class {

    func storeCounter(counter: Int) -> ReplaySubject<Void>
    func obtainCounter() -> ReplaySubject<Int?>

}
