//
//  WishMakerViewController.swift
//  mmvanurinaPW2
//
//  Created by Maria Vanurina on 25.11.2023.
//

import UIKit
import UIKit

final class WishMakerViewController: UIViewController {
    private static let titleFontSize: CGFloat = 32
        private static let paragraphFontSize: CGFloat = 17
        private static let stackViewSpacing: CGFloat = 20
        private static let redSliderMinValue: Double = 0
        private static let redSliderMaxValue: Double = 1
        private static let stackViewCornerRadius: CGFloat = 20
        private static let stackViewBottomConstraint: CGFloat = -40

    internal let h1: UILabel = {
        let h1 = UILabel()
        h1.translatesAutoresizingMaskIntoConstraints = false
        h1.text = "Прикол"
        h1.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        h1.textColor = .white
        h1.backgroundColor = .darkGray
        return h1
    }()

    let sliderRed = CustomSlider(title: "красный", min: redSliderMinValue, max: redSliderMaxValue)
    let sliderBlue = CustomSlider(title: "синий", min: redSliderMinValue, max: redSliderMaxValue)
    let sliderGreen = CustomSlider(title: "зеленый", min: redSliderMinValue, max: redSliderMaxValue)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        configureUI()
    }

    private func configureUI() {
        configureTitle()
        configureDescription()
        configureSliders()
    }

    private func configureTitle() {
        view.addSubview(h1)
        NSLayoutConstraint.activate([
            h1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            h1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerViewController.stackViewSpacing),
            h1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: WishMakerViewController.stackViewSpacing)
        ])
    }

    private func configureDescription() {
        let paragraph = UILabel()
        paragraph.translatesAutoresizingMaskIntoConstraints = false
        paragraph.text = "Удивительно, но эта штука работает. Я очень устала"
        paragraph.font = UIFont.systemFont(ofSize: WishMakerViewController.paragraphFontSize)
        paragraph.numberOfLines = 0
        paragraph.textColor = .white

        view.addSubview(paragraph)
        NSLayoutConstraint.activate([
            paragraph.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paragraph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerViewController.stackViewSpacing),
            paragraph.topAnchor.constraint(equalTo: h1.bottomAnchor, constant: WishMakerViewController.stackViewSpacing)
        ])
    }

    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = WishMakerViewController.stackViewCornerRadius
        stack.clipsToBounds = true

        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: WishMakerViewController.stackViewSpacing),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: WishMakerViewController.stackViewBottomConstraint)
        ])

        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slider.valueChanged = { [weak self] value in
                let red = CGFloat(self?.sliderRed.slider.value ?? 0)
                let blue = CGFloat(self?.sliderBlue.slider.value ?? 0)
                let green = CGFloat(self?.sliderGreen.slider.value ?? 0)
                self?.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            }
        }
    }

    final class CustomSlider: UIView {
        var valueChanged: ((Double) -> Void)?
        var slider = UISlider()
        var titleView = UILabel()

        init(title: String, min: Double, max: Double) {
            super.init(frame: .zero)
            titleView.text = title
            slider.minimumValue = Float(min)
            slider.maximumValue = Float(max)
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            configureUI()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func configureUI() {
            backgroundColor = .white
            translatesAutoresizingMaskIntoConstraints = false

            for view in [slider, titleView] {
                addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
            }

            NSLayoutConstraint.activate([
                titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleView.topAnchor.constraint(equalTo: topAnchor, constant: stackViewSpacing),
                titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: stackViewSpacing),

                slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
                slider.centerXAnchor.constraint(equalTo: centerXAnchor),
                slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -stackViewSpacing),
                slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: stackViewSpacing)
            ])
        }

        @objc
        private func sliderValueChanged() {
            valueChanged?(Double(slider.value))
        }
    }
}
