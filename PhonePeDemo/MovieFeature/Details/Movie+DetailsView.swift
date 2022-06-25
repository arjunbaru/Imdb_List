//
//  Movie+DetailsView.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI

extension Movie {
    struct DetailsView: View {
        let model: Movie

        var body: some View {
            Text(model.title)
                .navigationBarTitle(model.title, displayMode: .inline)
        }
    }
}
