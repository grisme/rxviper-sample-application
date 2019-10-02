//
//  CounterViewController.swift
//  RxVIPER
//
//  Created by Eugene Garifullin on 29.09.2019.

//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


// MARK: - CounterViewProtocol implementation
extension CounterViewController: CounterViewProtocol {
}


// MARK: - CounterViewController implementation
class CounterViewController: UIViewController {

    // MARK: - Module properties
    let disposeBag = DisposeBag()
    let onViewDidLoad = PublishSubject<Void>()
    let countUpButtonPressed = PublishSubject<Void>()
    let resetButtonPressed = PublishSubject<Void>()
    var presenter: CounterPresenterProtocol? {
        didSet {
            // --- Subscriptions to Presenter's subjects
            self.presenter?.shouldUpdateCounter.subscribe(onNext: { [weak self] value in
                self?.counterLabel.text = "\(value)"
            }, onError: { error in
                NSLog(error.localizedDescription)
            }).disposed(by: self.disposeBag)

            self.presenter?.countUpAvailable.bind(to: self.countButton.rx.isEnabled).disposed(by: self.disposeBag)
            self.presenter?.countUpAvailable.map(!).bind(to: self.progressIndicator.rx.isAnimating).disposed(by: self.disposeBag)
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        addSubviews()
        makeConstraints()
        self.onViewDidLoad.onNext(())
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubview(progressIndicator)
        view.addSubview(counterLabel)
        view.addSubview(countButton)
    }

    private func makeConstraints() {
        progressIndicator.snp.makeConstraints { make in
            make.top.equalTo(countButton.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
        }

        counterLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        countButton.snp.makeConstraints { make in
            make.top.equalTo(counterLabel.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - UI properties
    private lazy var counterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Appearance.counterLabelFont
        label.textColor = Appearance.counterLabelColor
        label.text = "0"
        return label
    }()

    private lazy var progressIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var countButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(Appearance.countButtonColor, for: .normal)
        button.setTitleColor(Appearance.countButtonDisabledColor, for: .disabled)
        button.setTitle(Texts.countButtonText, for: .normal)
        button.titleLabel?.font = Appearance.countButtonFont
        button.rx.tap.bind(to: self.countUpButtonPressed).disposed(by: self.disposeBag)
        return button
    }()
}

// MARK: - CounterViewController implementation
extension CounterViewController {
    enum Appearance {
        static let backgroundColor: UIColor = .white
        static let counterLabelFont: UIFont = .systemFont(ofSize: 32.0, weight: .heavy)
        static let counterLabelColor: UIColor = .black
        static let countButtonFont: UIFont = .systemFont(ofSize: 24.0, weight: .medium)
        static let countButtonColor: UIColor = .blue
        static let countButtonDisabledColor: UIColor = .gray
    }

    enum Texts {
        static let countButtonText = "Count +1"
    }
}
