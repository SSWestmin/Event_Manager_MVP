//
//  InteractiveMapView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 26/05/2026.
//

import SwiftUI

struct InteractiveMapView: View {
    var body: some View{
        VStack{
            //        MARK: Top nav button 
            Button {
            } label: {
                Label("Back to browse events", systemImage: "arrow.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //         MARK: reusable map view
            MapView()
        }
    }
}
#Preview {
    InteractiveMapView()
}
