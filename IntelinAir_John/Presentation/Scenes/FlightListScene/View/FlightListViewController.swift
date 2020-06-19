//
//  FlightListViewController.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import UIKit

class FlightListViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Members
    var viewModel: FlightListViewModel! = DefaultFlightListViewModel(with: DefaultFlightService(provider: URLSessionProvider()))
    
    private var sections: [FlightSectionViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        viewModel.retrieveFlights()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Private functions
    private func setupViews() {
        tableView.register(FlightTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
}


// MARK: - UITableViewDataSource
extension FlightListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FlightTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fill(with: sections[indexPath.section].rows[indexPath.row])
        return cell
    }
}


// MARK: - UITableViewDelegate
extension FlightListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}


// MARK: - Binding
 extension FlightListViewController {
    
    private func bind() {
        
        viewModel.sections.subscribe(on: self, closure: { [weak self] in
            self?.sections = $0
        })
        
        viewModel.selectedPathAction = { [weak self] in
            
            let flightMapViewController: FlightMapViewController = UIStoryboard.loadViewController(with: .flightMap)
            flightMapViewController.viewModel = self?.viewModel.flightMapViewModel
            self?.navigationController?.pushViewController(flightMapViewController, animated: true)
        }
    }
}
