//
//  MaskTests.swift
//  textField_mask_sample
//
//  Created by Kentaro on 2017/09/01.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
@testable import textField_mask_sample

/// 文字列マスクのテスト
class MaskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMaskText() {

        let displayText = "hogehoge"
        let maskedText = Mask.maskText(text: displayText)

        XCTAssertEqual(maskedText, "●●●●●oge")
    }
    
}
