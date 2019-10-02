//
//  CounterViewProtocol.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 29.09.2019.

//

import Foundation
import RxSwift
import RxRelay

protocol CounterViewProtocol: class {
    var presenter: CounterPresenterProtocol? { get set }
    
    var onViewDidLoad: PublishSubject<Void> { get }
    var countUpButtonPressed: PublishSubject<Void> { get }
    var resetButtonPressed: PublishSubject<Void> { get }
}
