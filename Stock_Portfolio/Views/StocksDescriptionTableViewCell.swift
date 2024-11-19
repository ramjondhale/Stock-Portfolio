//
//  StocksDescriptionTableViewCell.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import UIKit

class StocksDescriptionTableViewCell: UITableViewCell {

    static let cellIdentifier = "StocksDescriptionTableViewCell"

    // MARK: - Properties

    let stockNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let stockQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let lastTradedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    let profitAndLossLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        setupStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public API

    func configure(with holding: Holding) {
        stockNameLabel.text = holding.symbol
        stockQuantityLabel.text = "NET QTY: \(holding.quantity)"
        lastTradedPriceLabel.text = "LTP: \u{20B9} \(String(format: "%.2f", holding.lastTradedPrice))"

        let pnlAttributedString = createAttributedString(for: holding)
        profitAndLossLabel.attributedText = pnlAttributedString
    }

    // MARK: - Private Helpers

    private func setupSubViews() {
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(stockQuantityLabel)
        contentView.addSubview(lastTradedPriceLabel)
        contentView.addSubview(profitAndLossLabel)
        contentView.addSubview(dividerView)

        setupConstraints()
    }

    private func setupStyle() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    private func setupConstraints() {
        stockNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stockQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        lastTradedPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        profitAndLossLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stockNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stockNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            stockQuantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stockQuantityLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 20),
            stockQuantityLabel.bottomAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: -20),

            lastTradedPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo:  stockNameLabel.trailingAnchor, constant: 20),
            lastTradedPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lastTradedPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            profitAndLossLabel.leadingAnchor.constraint(greaterThanOrEqualTo: stockQuantityLabel.trailingAnchor, constant: 20),
            profitAndLossLabel.topAnchor.constraint(equalTo: lastTradedPriceLabel.bottomAnchor, constant: 20),
            profitAndLossLabel.trailingAnchor.constraint(equalTo: lastTradedPriceLabel.trailingAnchor),
            profitAndLossLabel.bottomAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: -20),

            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func createAttributedString(for holding: Holding) -> NSAttributedString {
        let fullText = "P&L: \u{20B9} \(holding.pnlString)"

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: holding.pnlColor
        ]

        let attributedString = NSMutableAttributedString(string: fullText)

        let symbolRange = (fullText as NSString).range(of: "\u{20B9}")
        attributedString.addAttributes(attributes, range: symbolRange)
        let valueRange = (fullText as NSString).range(of: holding.pnlString)
        attributedString.addAttributes(attributes, range: valueRange)

        return attributedString
    }
}
