//
//  SuffixUtil.swift
//  AppWithExtension
//
//  Created by Zelinskaya Anna on 22.02.2021.
//

import Foundation

struct TextManager {
	
	func reverseText(_ text: String) -> (time: String, reversedText: String) {
		var reversedText = ""
		let time = TimeProfiler.getOperationTime {
			reversedText = String(text.reversed())
		}
		return (time, reversedText)
	}
	
}
