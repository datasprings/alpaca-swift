//
//  File.swift
//  
//
//  Created by Andrew Barba on 8/25/20.
//

import Foundation

struct BarsResponse: Codable {
    let bars: [String: [Bar]]
    let nextPageToken: String?

    enum CodingKeys: String, CodingKey {
        case bars
        case nextPageToken = "next_page_token"
    }
}

public struct Bar: Codable {
      public enum Timeframe: String, CaseIterable {
        case oneMin = "1Min"
        case fiveMin = "5Min"
        case fifteenMin = "15Min"
        case oneDay = "1D"
    }
    
    let t: String
    let o: Double
    let h: Double
    let l: Double
    let c: Double
    let v: Int
    let n: Int
    let vw: Double
}

public struct BarOLD: Codable {

  
    
    let t: String
    let o: Double
    let h: Double
    let l: Double
    let c: Double
    let v: Int
    let n: Int
    let vw: Double

    enum CodingKeys: String, CodingKey {
        case t, o, h, l, c, v, n, vw
    }
}

extension AlpacaDataClient {

    public func bars(_ timeframe: Bar.Timeframe, symbols: [String], limit: Int? = nil, start: Date? = nil, end: Date? = nil, after: Date? = nil, until: Date? = nil) async throws -> Data {
        return try await get("stocks/bars", searchParams: [
            "timeframe": timeframe.rawValue,
            "symbols": symbols.joined(separator: ","),
            "limit": limit.map(String.init),
            "start": start.map(Utils.iso8601DateFormatter.string),
            "end": end.map(Utils.iso8601DateFormatter.string),
            "after": after.map(Utils.iso8601DateFormatter.string),
            "until": until.map(Utils.iso8601DateFormatter.string)
        ])
    }
   public func bars(_ timeframe: Bar.Timeframe, symbol: String, limit: Int? = nil, start: Date? = nil, end: Date? = nil, after: Date? = nil, until: Date? = nil) async throws -> Data {
    return try await bars(timeframe, symbols: [symbol], limit: limit, start: start, end: end, after: after, until: until)
}

public func bars(_ timeframe: Bar.Timeframe, assets: [Asset], limit: Int? = nil, start: Date? = nil, end: Date? = nil, after: Date? = nil, until: Date? = nil) async throws -> Data {
    return try await bars(timeframe, symbols: assets.map(\.symbol), limit: limit, start: start, end: end, after: after, until: until)
}

public func bars(_ timeframe: Bar.Timeframe, asset: Asset, limit: Int? = nil, start: Date? = nil, end: Date? = nil, after: Date? = nil, until: Date? = nil) async throws -> Data {
    return try await bars(timeframe, symbol: asset.symbol, limit: limit, start: start, end: end, after: after, until: until)
}

}
