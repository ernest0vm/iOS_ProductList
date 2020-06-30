//
//  Response.swift
//  iostest
//
//  Created by Ernesto Valdez on 30/06/20.
//  Copyright © 2020 Ernesto Valdez. All rights reserved.
//

import Foundation

// MARK: - ApiResponse
class ApiResponse: Codable {
    let status: Status
    let pageType: String
    let plpResults: PlpResults

    init(status: Status, pageType: String, plpResults: PlpResults) {
        self.status = status
        self.pageType = pageType
        self.plpResults = plpResults
    }
}

// MARK: - PlpResults
class PlpResults: Codable {
    let label: String
    let plpState: PlpState
    let sortOptions: [SortOption]
    let refinementGroups: [RefinementGroup]
    let records: [Record]
    let navigation: Navigation

    init(label: String, plpState: PlpState, sortOptions: [SortOption], refinementGroups: [RefinementGroup], records: [Record], navigation: Navigation) {
        self.label = label
        self.plpState = plpState
        self.sortOptions = sortOptions
        self.refinementGroups = refinementGroups
        self.records = records
        self.navigation = navigation
    }
}

// MARK: - Navigation
class Navigation: Codable {
    let ancester: [JSONAny]
    let current: [Current]
    let childs: [JSONAny]

    init(ancester: [JSONAny], current: [Current], childs: [JSONAny]) {
        self.ancester = ancester
        self.current = current
        self.childs = childs
    }
}

// MARK: - Current
class Current: Codable {
    let label, categoryID: String

    enum CodingKeys: String, CodingKey {
        case label
        case categoryID = "categoryId"
    }

    init(label: String, categoryID: String) {
        self.label = label
        self.categoryID = categoryID
    }
}

// MARK: - PlpState
class PlpState: Codable {
    let categoryID, currentSortOption, currentFilters: String
    let firstRecNum, lastRecNum, recsPerPage, totalNumRecs: Int

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case currentSortOption, currentFilters, firstRecNum, lastRecNum, recsPerPage, totalNumRecs
    }

    init(categoryID: String, currentSortOption: String, currentFilters: String, firstRecNum: Int, lastRecNum: Int, recsPerPage: Int, totalNumRecs: Int) {
        self.categoryID = categoryID
        self.currentSortOption = currentSortOption
        self.currentFilters = currentFilters
        self.firstRecNum = firstRecNum
        self.lastRecNum = lastRecNum
        self.recsPerPage = recsPerPage
        self.totalNumRecs = totalNumRecs
    }
}

// MARK: - Record
class Record: Codable, Identifiable {
    let productID, skuRepositoryID, productDisplayName, productType: String
    let productRatingCount: Int
    let productAvgRating: Double
    let listPrice, minimumListPrice, maximumListPrice: Int
    let promoPrice, minimumPromoPrice, maximumPromoPrice: Double
    let isHybrid, isMarketPlace, isImportationProduct: Bool
    let smImage, lgImage, xlImage: String
    let groupType: String
    let plpFlags: [JSONAny]
    let variantsColor: [VariantsColor]
    let marketplaceSLMessage, marketplaceBTMessage: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case skuRepositoryID = "skuRepositoryId"
        case productDisplayName, productType, productRatingCount, productAvgRating, listPrice, minimumListPrice, maximumListPrice, promoPrice, minimumPromoPrice, maximumPromoPrice, isHybrid, isMarketPlace, isImportationProduct, smImage, lgImage, xlImage, groupType, plpFlags, variantsColor, marketplaceSLMessage, marketplaceBTMessage
    }

    init(productID: String, skuRepositoryID: String, productDisplayName: String, productType: String, productRatingCount: Int, productAvgRating: Double, listPrice: Int, minimumListPrice: Int, maximumListPrice: Int, promoPrice: Double, minimumPromoPrice: Double, maximumPromoPrice: Double, isHybrid: Bool, isMarketPlace: Bool, isImportationProduct: Bool, smImage: String, lgImage: String, xlImage: String, groupType: String, plpFlags: [JSONAny], variantsColor: [VariantsColor], marketplaceSLMessage: String?, marketplaceBTMessage: String?) {
        self.productID = productID
        self.skuRepositoryID = skuRepositoryID
        self.productDisplayName = productDisplayName
        self.productType = productType
        self.productRatingCount = productRatingCount
        self.productAvgRating = productAvgRating
        self.listPrice = listPrice
        self.minimumListPrice = minimumListPrice
        self.maximumListPrice = maximumListPrice
        self.promoPrice = promoPrice
        self.minimumPromoPrice = minimumPromoPrice
        self.maximumPromoPrice = maximumPromoPrice
        self.isHybrid = isHybrid
        self.isMarketPlace = isMarketPlace
        self.isImportationProduct = isImportationProduct
        self.smImage = smImage
        self.lgImage = lgImage
        self.xlImage = xlImage
        self.groupType = groupType
        self.plpFlags = plpFlags
        self.variantsColor = variantsColor
        self.marketplaceSLMessage = marketplaceSLMessage
        self.marketplaceBTMessage = marketplaceBTMessage
    }
}

// MARK: - VariantsColor
class VariantsColor: Codable {
    let colorName, colorHex, colorImageURL: String

    init(colorName: String, colorHex: String, colorImageURL: String) {
        self.colorName = colorName
        self.colorHex = colorHex
        self.colorImageURL = colorImageURL
    }
}

// MARK: - RefinementGroup
class RefinementGroup: Codable {
    let name: String
    let refinement: [Refinement]
    let multiSelect: Bool
    let dimensionName: String

    init(name: String, refinement: [Refinement], multiSelect: Bool, dimensionName: String) {
        self.name = name
        self.refinement = refinement
        self.multiSelect = multiSelect
        self.dimensionName = dimensionName
    }
}

// MARK: - Refinement
class Refinement: Codable {
    let count: Int
    let label, refinementID: String
    let selected: Bool
    let colorHex: String?

    enum CodingKeys: String, CodingKey {
        case count, label
        case refinementID = "refinementId"
        case selected, colorHex
    }

    init(count: Int, label: String, refinementID: String, selected: Bool, colorHex: String?) {
        self.count = count
        self.label = label
        self.refinementID = refinementID
        self.selected = selected
        self.colorHex = colorHex
    }
}

// MARK: - SortOption
class SortOption: Codable {
    let sortBy, label: String

    init(sortBy: String, label: String) {
        self.sortBy = sortBy
        self.label = label
    }
}

// MARK: - Status
class Status: Codable {
    let status: String
    let statusCode: Int

    init(status: String, statusCode: Int) {
        self.status = status
        self.statusCode = statusCode
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
