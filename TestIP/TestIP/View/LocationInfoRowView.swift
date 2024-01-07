//
//  LocationInfoRowView.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 05.01.2024.
//

import Foundation
import SwiftUI

struct LocationInfoRow: View {
    var entity: ResultEntity
    var body: some View {
        Text(entity.name + ": " + entity.value)
    }
}
