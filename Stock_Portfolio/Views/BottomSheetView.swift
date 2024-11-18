//
//  BottomSheetView.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import UIKit

class BottomSheetView: UIView {

    // MARK: - Properties

    private let currentValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let totalInvestmentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let todayPNLLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let currentAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let totalInvestmentAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let pnlAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let pnlLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()

    let totalPNLAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()

    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private let pnlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        return stackView
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()

    private var isContainerHidden = false

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(currentValue: String, totalInvestment: String, todaysPNL: String, totalPNL: String) {
        currentAmountLabel.text = "\u{20B9} \(currentValue)"
        totalInvestmentAmountLabel.text = "\u{20B9} \(totalInvestment)"
        pnlAmountLabel.text = "\u{20B9} \(todaysPNL)"
        pnlAmountLabel.textColor = UIColor.getPNLColor(pnlValue: Double(todaysPNL) ?? 0)
        totalPNLAmountLabel.text = "\u{20B9} \(totalPNL)"
        totalPNLAmountLabel.textColor = UIColor.getPNLColor(pnlValue: Double(totalPNL) ?? 0)
    }

    // MARK: - Setup Methods

    private func setupView() {
        setupSubviews()
        styliseViews()
        configureLabels()
        setupConstraints()
    }

    private func styliseViews() {
        backgroundColor = .spLightGray
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    private func configureLabels() {
        currentValueLabel.attributedText = getLabelTextWithSuperscriptStar(mainText: "Current value")
        totalInvestmentLabel.attributedText = getLabelTextWithSuperscriptStar(mainText: "Total investment")
        todayPNLLabel.attributedText = getLabelTextWithSuperscriptStar(mainText: "Today's Profit & Loss")
        configurePnlLabel(withText: "Profit & Loss", imageName: "chevron.up")
    }

    private func setupSubviews() {
        let currentValueStack = createHorizontalStack(for: currentValueLabel, and: currentAmountLabel)
        let totalInvestmentStack = createHorizontalStack(for: totalInvestmentLabel, and: totalInvestmentAmountLabel)
        let todayPNLStack = createHorizontalStack(for: todayPNLLabel, and: pnlAmountLabel)

        containerStackView.addArrangedSubview(currentValueStack)
        containerStackView.addArrangedSubview(totalInvestmentStack)
        containerStackView.addArrangedSubview(todayPNLStack)

        pnlStackView.addArrangedSubview(pnlLabel)
        pnlStackView.addArrangedSubview(totalPNLAmountLabel)

        mainStackView.addArrangedSubview(containerStackView)
        mainStackView.addArrangedSubview(dividerView)
        mainStackView.addArrangedSubview(pnlStackView)

        addSubview(mainStackView)
    }

    private func setupConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: safeAreaInsets.bottom),

            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePnlStackTap))
        pnlStackView.addGestureRecognizer(tapGesture)
    }

    @objc func handlePnlStackTap() {
        isContainerHidden.toggle()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [weak self] in
            guard let self else { return }
            containerStackView.isHidden = isContainerHidden
            dividerView.isHidden = isContainerHidden
        }
        if isContainerHidden {
            configurePnlLabel(withText: "Profit & Loss", imageName: "chevron.up")
        } else {
            configurePnlLabel(withText: "Profit & Loss", imageName: "chevron.down")
        }
    }

    private func createHorizontalStack(for valueLabel: UILabel, and amountLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, amountLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }

    private func getLabelTextWithSuperscriptStar(mainText: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: mainText)
        let superscriptStar = NSAttributedString(
            string: " *",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .baselineOffset: 1
            ]
        )
        attributedText.append(superscriptStar)
        return attributedText
    }

    private func configurePnlLabel(withText text: String, imageName: String) {
        let fullText = NSMutableAttributedString(attributedString: getLabelTextWithSuperscriptStar(mainText: text))
        if let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate) {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 10) // Adjust size and position
            let imageString = NSAttributedString(attachment: imageAttachment)
            fullText.append(imageString)
        }

        pnlLabel.attributedText = fullText
    }
}
