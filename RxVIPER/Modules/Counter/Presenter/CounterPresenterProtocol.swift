//
//  CounterPresenterProtocol.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 29.09.2019.

//

import Foundation
import RxSwift
import RxCocoa

protocol CounterPresenterProtocol: class {
    var view: CounterViewProtocol? { get set }
    var interactor: CounterInteractorProtocol? { get set }

    var countUpAvailable: BehaviorSubject<Bool> { get }
    var shouldUpdateCounter: BehaviorSubject<Int> { get }

}
