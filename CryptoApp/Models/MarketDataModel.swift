//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by MacBook on 10/11/2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketDataModel = try? JSONDecoder().decode(MarketDataModel.self, from: jsonData)


//json data
//api url :  https://api.coingecko.com/api/v3/global
//{
//    "data": {
//        "active_cryptocurrencies": 15116,
//        "upcoming_icos": 0,
//        "ongoing_icos": 49,
//        "ended_icos": 3376,
//        "markets": 1148,
//        "total_market_cap": {
//            "btc": 35679721.9568273,
//            "eth": 908447016.7383695,
//            "ltc": 37920505740.59095,
//            "bch": 6593923125.693103,
//            "bnb": 4603928384.681578,
//            "eos": 5044377204604.086,
//            "xrp": 4900751490295.839,
//            "xlm": 26748222692734.203,
//            "link": 202617768632.3425,
//            "dot": 559287255612.1687,
//            "yfi": 417142343.57596743,
//            "usd": 2869448884144.2764,
//            "aed": 10539436970830.898,
//            "ars": 2870557306337039,
//            "aud": 4359011363841.283,
//            "bdt": 344810191742631.94,
//            "bhd": 1086528297776.7659,
//            "bmd": 2869448884144.2764,
//            "brl": 16466673886079.146,
//            "cad": 3991518175800.0503,
//            "chf": 2512937076982.655,
//            "clp": 2773807785540416,
//            "cny": 20600232651093.22,
//            "czk": 67630758112617.414,
//            "dkk": 19975361375939.758,
//            "eur": 2678719486264.0884,
//            "gbp": 2222589022191.6294,
//            "gel": 7804900964872.415,
//            "hkd": 22310811561642.58,
//            "huf": 1090433528755169.6,
//            "idr": 44920558213331750,
//            "ils": 10776631354492.035,
//            "inr": 242139092583962.38,
//            "jpy": 438151483450519.5,
//            "krw": 4012626275078611,
//            "kwd": 881712775324.3171,
//            "lkr": 844204478681990.9,
//            "mmk": 6020103758934681,
//            "mxn": 57846396529507.04,
//            "myr": 12575359734762.293,
//            "ngn": 4811778960077277,
//            "nok": 31588287868817.855,
//            "nzd": 4809879258660.245,
//            "php": 167752076470631.88,
//            "pkr": 800591690658493.4,
//            "pln": 11584409909867.477,
//            "rub": 281265996561204.3,
//            "sar": 10775294191312,
//            "sek": 31069876016715.066,
//            "sgd": 3809078615746.1606,
//            "thb": 98333143810740.3,
//            "try": 98629859172605.17,
//            "twd": 92541651913854.11,
//            "uah": 119123804567580.69,
//            "vef": 287317916769.3662,
//            "vnd": 72524959681985280,
//            "zar": 50574111188713.98,
//            "xdr": 2163426725098.346,
//            "xag": 91650799943.83365,
//            "xau": 1068841014.8549002,
//            "bits": 35679721956827.3,
//            "sats": 3567972195682730
//        },
//        "total_volume": {
//            "btc": 3662559.3992949673,
//            "eth": 93253001.35305347,
//            "ltc": 3892578111.855055,
//            "bch": 676872850.9560179,
//            "bnb": 472597886.2559449,
//            "eos": 517810401288.083,
//            "xrp": 503067077039.1823,
//            "xlm": 2745732003075.844,
//            "link": 20798918048.366646,
//            "dot": 57411400162.44635,
//            "yfi": 42820081.75839343,
//            "usd": 294551818372.79095,
//            "aed": 1081883821502.3489,
//            "ars": 294665599027399.2,
//            "aud": 447456907360.10754,
//            "bdt": 35395113512032.95,
//            "bhd": 111533224234.13068,
//            "bmd": 294551818372.79095,
//            "brl": 1690320661398.6475,
//            "cad": 409733361429.2867,
//            "chf": 257955522250.8819,
//            "clp": 284734163261175.44,
//            "cny": 2114634632389.2053,
//            "czk": 6942365445182.8955,
//            "dkk": 2050490966557.6162,
//            "eur": 274973253557.3697,
//            "gbp": 228151001957.01242,
//            "gel": 801180945973.9896,
//            "hkd": 2290227280634.87,
//            "huf": 111934100127829.56,
//            "idr": 4611140549382373,
//            "ils": 1106232063912.681,
//            "inr": 24855821762098.895,
//            "jpy": 44976691129165.72,
//            "krw": 411900129082562.94,
//            "kwd": 90508704542.31775,
//            "lkr": 86658440109620.6,
//            "mmk": 617969714946114.2,
//            "mxn": 5937990872822.633,
//            "myr": 1290873344018.7566,
//            "ngn": 493933957189612.06,
//            "nok": 3242569568831.4087,
//            "nzd": 493738950925.57153,
//            "php": 17219919627518.154,
//            "pkr": 82181543487550.53,
//            "pln": 1189151346302.804,
//            "rub": 28872237868159.324,
//            "sar": 1106094802765.3167,
//            "sek": 3189354070013.272,
//            "sgd": 391005756817.145,
//            "thb": 10093996263817.182,
//            "try": 10124454394596.014,
//            "twd": 9499493786792.629,
//            "uah": 12228178533080.861,
//            "vef": 29493473573.667538,
//            "vnd": 7444760166241042,
//            "zar": 5191483457167.73,
//            "xdr": 222077932565.80252,
//            "xag": 9408046934.70878,
//            "xau": 109717606.82568076,
//            "bits": 3662559399294.9673,
//            "sats": 366255939929496.75
//        },
//        "market_cap_percentage": {
//            "btc": 55.439123163388345,
//            "eth": 13.303800673303407,
//            "usdt": 4.285811745931629,
//            "sol": 3.431050844685104,
//            "bnb": 3.172292307939606,
//            "doge": 1.3888314096017174,
//            "usdc": 1.286026601749565,
//            "xrp": 1.1609144778424303,
//            "steth": 1.0816549453292403,
//            "ada": 0.7243308257581094
//        },
//        "market_cap_change_percentage_24h_usd": 3.282650061083101,
//        "updated_at": 1731278750
//    }
//}

import Foundation

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"

    }
    
    private func currencyCheck(key: String) -> Bool {
        key.contains("usd")
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: {currencyCheck(key: $0.key)}) {
            return "\(item.value)"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {currencyCheck(key: $0.key)}) {
            return "\(item.value)"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {currencyCheck(key: $0.key)}) {
            return item.value.asPercentString()
        }
        return ""
    }
      
}
