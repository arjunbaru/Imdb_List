//
//  View+Extensions.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI

extension View {
    /// Embeds current view into naviigation
    func embedInNavigation() -> some View  {
        NavigationView { self }
        .navigationViewStyle(.stack)
    }

    /// Navigates to  destination based on a binding
    func navigationLink<Item, Destination: View>(_ item: Binding<Item?>, @ViewBuilder destination: @escaping (Item) -> Destination) -> some View {
        navigationLink(
            isActive: Binding(
                get: { item.wrappedValue != nil},
                set: { if !$0 { item.wrappedValue = nil } }
            ),
            destination: {
                if let item = item.wrappedValue {
                    destination(item)
                }
            })
    }

    /// Navigates to destination based on a boolean
    func navigationLink<Destination: View>(isActive: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier(isActive: isActive, destination: destination))
    }
}

/// Private view modifier for naviagtion
private struct NavigationLinkModifier<Destination: View>: ViewModifier {
    var isActive: Binding<Bool>
    var destination: () -> Destination

    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(
                    isActive: isActive,
                    destination: {
                        destination()
                    },
                    label: EmptyView.init
                )
            )
    }
}
