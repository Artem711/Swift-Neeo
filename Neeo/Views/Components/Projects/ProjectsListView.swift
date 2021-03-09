//
//  ProjectsListView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectsListView: View {
    // MARK: - State
    @StateObject var viewModel = ProjectsViewModel()
    
    // MARK: - UI Components
    var body: some View {
        // LazyGridView columns
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        VStack(alignment: .leading, spacing: 20) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(self.viewModel.projects) { project in
                    ProjectItemView(project: project)
                } //: FOR_EACH
            } //: LAZY_V_GRID
            .padding(.horizontal)
        } //: VSTACK
        .onAppear() { self.onAppear() }
        .onDisappear() { self.onDisappear() }
    }
    
    // MARK: - Action Functions
    private func onAppear() {
        print("ProjectsListView appears. Subscribing to data updates.")
        self.viewModel.subscribe()
    }
    
    private func onDisappear() {
        /* By unsubscribing from the view model, we prevent updates coming in from
           Firestore to be reflected in the UI. Since we do want to receive updates
           when the user is on any of the child screens, we keep the subscription active!
           print("BooksListView disappears. Unsubscribing from data updates.") */
        self.viewModel.unsubscribe()
    }
}

struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}