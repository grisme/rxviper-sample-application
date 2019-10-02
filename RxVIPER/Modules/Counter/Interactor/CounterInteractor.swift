//
//  CounterInteractor.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 02.10.2019.

//

import Foundation
import RxSwift

class CounterInteractor: CounterInteractorProtocol {

    func storeCounter(counter: Int) -> ReplaySubject<Void> {
        let subject = ReplaySubject<Void>.create(bufferSize: 1)
        DispatchQueue.global().async {
            let defaults = UserDefaults.standard
            defaults.set(counter, forKey: "counter")
            defaults.synchronize()

            sleep(1) // Imitating long working...

            DispatchQueue.main.async {
                subject.onNext(())
            }
        }
        return subject
    }

    func obtainCounter() -> ReplaySubject<Int?> {
        let subject = ReplaySubject<Int?>.create(bufferSize: 1)
        DispatchQueue.global().async {
            let defaults = UserDefaults.standard
            let value = defaults.value(forKey: "counter") as? Int

            sleep(1) // Imitating long working...

            DispatchQueue.main.async {
                subject.onNext(value)
            }
        }
        return subject
    }

}
