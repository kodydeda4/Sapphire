//
//  GridDetailView.swift
//  Sapphire
//
//  Created by Kody Deda on 5/19/21.
//

import SwiftUI
import ComposableArchitecture

struct GridDetailView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                if viewStore.macOSApplications.filter(\.selected).isEmpty {
                    Text("No Selection")
                        .font(.title)
                        .foregroundColor(Color(.disabledControlTextColor))
                } else {
                        ForEachStore(store.scope(
                            state: { $0.macOSApplications.filter(\.selected) },
                            action: Root.Action.macOSApplication(index:action:)
                        ), content: MacOSApplicationSelectedView.init(store:))
                    
                    Button("Create Icon") {
                        viewStore.send(.createIconButtonTapped)
                    }
                }
                Spacer()
            }
            .fixedSize()
            .toolbar {
                ToolbarItem {
                    Button<Image>("checkmark.circle") {
                        viewStore.send(.applyChanges)
                    }
                    .help("Apply Changes")
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct GridDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GridDetailView(store: Root.defaultStore)
    }
}
