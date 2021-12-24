//
//  StationDetailViewController.swift
//  MySubwayStation
//
//  Created by yc on 2021/12/23.
//

import UIKit
import SnapKit
import Alamofire

class StationDetailViewController: UIViewController {
    
    private let station: Station
    private var realTimeArrivalList = [RealTimeArrival]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StationDetailCollectionViewCell.self, forCellWithReuseIdentifier: "StationDetailCollectionViewCell")
        
        return collectionView
    }()
    
    init(station: Station) {
        self.station = station
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupLayout()
        fetchData(from: station)
    }
}
extension StationDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        return CGSize(width: width - 32.0, height: 80.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInset: CGFloat = 16.0
        return UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realTimeArrivalList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationDetailCollectionViewCell", for: indexPath) as? StationDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let realTimeArrival = realTimeArrivalList[indexPath.item]
        
        cell.setupViews(realTimeArrival: realTimeArrival)
        
        return cell
    }
}

private extension StationDetailViewController {
    func setupNavigationItem() {
        navigationItem.title = "\(station.stationName)"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setupLayout() {
        [
            collectionView
        ].forEach{ view.addSubview($0) }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func fetchData(from station: Station) {
        let stationName = station.stationName.last == "역" ? String(Array(station.stationName)[0..<station.stationName.count - 1]) : station.stationName

        let url = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
        
        AF
            .request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDataResponseModel.self) { [weak self] response in
                guard let self = self,
                    case .success(let data) = response.result else { return }
                
                self.realTimeArrivalList = data.realtimeArrivalList
                self.collectionView.reloadData()
                
            }
            .resume()
    }
}
