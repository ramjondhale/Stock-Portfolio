//
//  HoldingsViewController.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import UIKit

class HoldingsViewController: UIViewController {

    private let viewModel: HoldingsViewModel
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let bottomSheetView = BottomSheetView()

    // MARK: - Initializer

    init(viewModel: HoldingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Task {
            await fetchData()
        }
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(bottomSheetView)
        view.backgroundColor = .white

        setupConstraints()

        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(StocksDescriptionView.self, forCellReuseIdentifier: StocksDescriptionView.cellIdentifier)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // MARK: - Data Fetching

    private func fetchData() async {
        activityIndicator.startAnimating()
        await viewModel.fetchHoldings()
        activityIndicator.stopAnimating()
        updateUI()
        bottomSheetView.configure(
            currentValue: viewModel.currentValue,
            totalInvestment: viewModel.totalInvestment,
            todaysPNL: viewModel.todaysPNL,
            totalPNL: viewModel.totalPNL
        )
    }

    // MARK: - Private Helpers

    private func updateUI() {
        if let errorMessage = viewModel.errorMessage {
            showErrorAlert(message: errorMessage)
        } else {
            tableView.reloadData()
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HoldingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.holdingsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StocksDescriptionView.cellIdentifier, for: indexPath) as! StocksDescriptionView
        if let holding = viewModel.holding(at: indexPath.row) {
            cell.configure(with: holding)
        }
        return cell
    }
}