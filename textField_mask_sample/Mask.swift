//
//  Mask.swift
//  textField_mask_sample
//
//  Created by Kentaro on 2017/09/01.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import Foundation

final class Mask {

    static let displayTextCount = 3
    static let maskText = "●"

    static func maskText(text: String) -> String {
        // 3文字以下だったらマスク不要
        guard text.characters.count > displayTextCount else {
            return text
        }

        // マスク部分
        let range = text.startIndex ..< text.index(text.endIndex, offsetBy: -displayTextCount)
        let substring = text.substring(with: range)
        let maskedText = Array(repeating: maskText, count: substring.characters.count).joined()

        // 表示部分
        let displayText = text.substring(from: text.index(text.endIndex, offsetBy: -displayTextCount))

        return maskedText + displayText
    }
}
