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
        
        return label
    }()
    
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .label
        
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
    func setupViews(station: Station) {
        setupLayout()
        
        stationNameLabel.text = station.stationName
        lineLabel.text = sliceLineNumberText(lineNumber: station.lineNumber)
        setupSubwayImageViewTintColor(station: station)
    }
    
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

private extension SubwayStationTableViewCell {
    func sliceLineNumberText(lineNumber: String) -> String {
        var lineNumber = lineNumber
        if lineNumber.first == "0" {
            lineNumber = String(Array(lineNumber)[1..<lineNumber.count])
        }
        return lineNumber
    }
    
    func setupRGBColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    func setupSubwayImageViewTintColor(station: Station) {
        switch station.lineNumber {
        case "01호선":
            subwayImageView.tintColor = setupRGBColor(red: 20, green: 29, blue: 128)
        case "02호선":
            subwayImageView.tintColor = setupRGBColor(red: 26, green: 153, blue: 52)
        case "03호선":
            subwayImageView.tintColor = setupRGBColor(red: 227, green: 112, blue: 11)
        case "04호선":
            subwayImageView.tintColor = setupRGBColor(red: 43, green: 150, blue: 253)
        case "05호선":
            subwayImageView.tintColor = setupRGBColor(red: 150, green: 56, blue: 130)
        case "06호선":
            subwayImageView.tintColor = setupRGBColor(red: 196, green: 123, blue: 21)
        case "07호선":
            subwayImageView.tintColor = setupRGBColor(red: 83, green: 104, blue: 37)
        case "08호선":
            subwayImageView.tintColor = setupRGBColor(red: 222, green: 53, blue: 90)
        case "09호선":
            subwayImageView.tintColor = setupRGBColor(red: 175, green: 131, blue: 23)
        case "수인분당선":
            subwayImageView.tintColor = setupRGBColor(red: 248, green: 203, blue: 10)
        default:
            subwayImageView.tintColor = .black
        }
    }
}
