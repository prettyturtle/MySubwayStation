//
//  SubwayStationTableViewCell.swift
//  MySubwayStation
//
//  Created by yc on 2021/12/22.
//

import UIKit
import SnapKit

class SubwayStationTableViewCell: UITableViewCell {
    private lazy var subwayImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "tram.fill")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var stationNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        label.text = "왕십리"
        
        return label
    }()
    
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .label
        label.text = "2호선"
        
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
        
        return imageView
    }()
}

extension SubwayStationTableViewCell {
    func setupLayout() {
        [
            subwayImageView,
            stationNameLabel,
            lineLabel,
            chevronImageView
        ].forEach { addSubview($0) }
        
        let inset = 16.0
        
        subwayImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(inset)
//            make.width.equalTo(subwayImageView.snp.height)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32.0)
        }
        stationNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(subwayImageView.snp.trailing).offset(inset)
            make.centerY.equalTo(subwayImageView.snp.centerY)
        }
        lineLabel.snp.makeConstraints { make in
            make.leading.equalTo(stationNameLabel.snp.trailing).offset(inset / 2)
            make.centerY.equalTo(subwayImageView.snp.centerY)
        }
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(inset)
            make.centerY.equalTo(subwayImageView.snp.centerY)
            make.width.height.equalTo(12.0)
        }
        
    }
}
