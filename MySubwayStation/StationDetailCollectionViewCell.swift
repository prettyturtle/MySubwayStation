//
//  StationDetailCollectionViewCell.swift
//  MySubwayStation
//
//  Created by yc on 2021/12/23.
//

import UIKit
import SnapKit

class StationDetailCollectionViewCell: UICollectionViewCell {
    
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
}

extension StationDetailCollectionViewCell {
    func setupViews(realTimeArrival: RealTimeArrival) {
        setupCollectionViewCell()
        setupLayout()
        
        lineLabel.text = "\(realTimeArrival.line)"
        remainTimeLabel.text = "\(realTimeArrival.remainTime)"
        
    }
    func setupLayout() {
        
        [
            lineLabel,
            remainTimeLabel
        ].forEach { addSubview($0) }
        
        let inset = 16.0
        
        lineLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(inset)
        }
        remainTimeLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(inset)
            make.top.equalTo(lineLabel.snp.bottom).offset(inset / 2)
        }
    }
    func setupCollectionViewCell() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10.0
        backgroundColor = .systemBackground
    }
}
