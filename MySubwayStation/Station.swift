//
//  Station.swift
//  MySubwayStation
//
//  Created by yc on 2021/12/23.
//

import Foundation

struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}

struct StationResponseModel: Decodable {
    let searchInfo: SearchInfoBySubwayNameServiceModel
    var stations: [Station] { searchInfo.row }
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
}

struct SearchInfoBySubwayNameServiceModel: Decodable {
    let row: [Station]
}
