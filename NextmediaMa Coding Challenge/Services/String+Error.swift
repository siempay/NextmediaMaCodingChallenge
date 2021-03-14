//
//  Error.swift
//  iMediaCodingChanlenge
//
//  Created by Brahim ELMSSILHA on 3/13/21.
//

import Foundation

extension String: Error { }

extension String {
    func replacingFirstOccurrence(of string: String, with replacement: String) -> String {
        guard let range = self.range(of: string) else { return self }
        return replacingCharacters(in: range, with: replacement)
    }
}
