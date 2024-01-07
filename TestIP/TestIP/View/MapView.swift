//
//  MapView.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 06.01.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    var viewModel: MapViewModel
    
    @Binding var showingSheet: Bool
    @State var region = MKCoordinateRegion(
        center: .init(),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Map(coordinateRegion: $region,
                annotationItems: viewModel.mapLocations,
                annotationContent: { location in
                  MapPin(coordinate: location.coordinate, tint: .red)
                }
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                region = MKCoordinateRegion(
                    center: .init(latitude: viewModel.getLat(), longitude: viewModel.getLon()),
                    span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
                )
            }
            
            VStack {
                Button(action: {
                    showingSheet.toggle()
                }, label: {
                    Image(systemName: "xmark.circle" )
                        .accentColor(.gray)
                        .padding(10)
                })
                Spacer()
            }
        }
    }
}
