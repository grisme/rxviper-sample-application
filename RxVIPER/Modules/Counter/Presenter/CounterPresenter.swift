//
//  CounterPresenter.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 29.09.2019.

//

import Foundation
import RxSwift
import RxCocoa

extension CounterPresenter: CounterPresenterProtocol {
}

class CounterPresenter {

    // MARK: - Module Properties
    var interactor: CounterInteractorProtocol?
    weak var view: CounterViewProtocol? {
        didSet {
            // Subscribtions to the view entity
            view?.countUpButtonPressed.subscribe({ [weak self] _ in
                self?.requestCountUp()
            }).disposed(by: disposeBag)

            view?.onViewDidLoad.subscribe(onNext: { _ in

                self.countUpAvailable.onNext(false)
                self.interactor?.obtainCounter().subscribe(onNext: { value in
                    let result = value ?? 0
                    self.shouldUpdateCounter.onNext(result)
                    self.countUpAvailable.onNext(true)
                }).disposed(by: self.disposeBag)

            }).disposed(by: disposeBag)
        }
    }

    // MARK: - Presenter's subjects
    private let disposeBag = DisposeBag()
    let shouldUpdateCounter = BehaviorSubject<Int>(value: 0)
    let countUpAvailable = BehaviorSubject<Bool>(value: true)

    // MARK: - Private methods
    private func requestCountUp() {
        let currentValue = (try? shouldUpdateCounter.value()) ?? 0
        countUpAvailable.onNext(false)
        interactor?.storeCounter(counter: currentValue + 1).subscribe(onNext: { [weak self] _ in
            self?.countUpAvailable.onNext(true)
            self?.shouldUpdateCounter.onNext(currentValue + 1)
        }).disposed(by: self.disposeBag)

    }
}
