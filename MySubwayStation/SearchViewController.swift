//
//  SearchViewController.swift
//  MySubwayStation
//
//  Created by yc on 2021/12/22.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: UIViewController {
    
    private var stations = [Station]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubwayStationTableViewCell.self, forCellReuseIdentifier: "SubwayStationTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupSearchController()
        setupLayout()
    }
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationDetailViewController = StationDetailViewController()
        
        navigationController?.pushViewController(stationDetailViewController, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubwayStationTableViewCell", for: indexPath) as? SubwayStationTableViewCell else { return UITableViewCell() }
        
        let station = stations[indexPath.row]
        
        cell.setupViews(station: station)
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        stations = []
        tableView.reloadData()
        tableView.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            fetchData(from: searchText)
        } else {
            stations = []
            tableView.reloadData()
        }
    }
    
}

private extension SearchViewController {
    func setupNavigationItem() {
        navigationItem.title = "지하철 도착 정보"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func fetchData(from stationName: String) {
        let url = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        AF
            .request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                guard let self = self,
                      case .success(let data) = response.result else { return }
                
                self.stations = data.stations
                self.tableView.reloadData()
                
            }
            .resume()
    }
}

