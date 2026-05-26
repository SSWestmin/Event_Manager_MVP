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
            // Note: nav not required auto toggle with nav stack
            //         MARK: reusable map view
            MapView()
        }
    } // VStack end

}
#Preview {
    InteractiveMapView()
}
