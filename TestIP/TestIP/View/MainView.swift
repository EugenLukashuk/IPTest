//
//  ContentView.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 05.01.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchField(searchText: $viewModel.searchText, isTextValid: $viewModel.isTextValid, textFieldColor: $viewModel.textFieldColor, viewModel: viewModel)
                SearchButtonsView(viewModel: viewModel)
                ZStack {
                    List(viewModel.results) { entity in
                        LocationInfoRow(entity: entity)
                    }
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.top, 10)
                    .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                        Alert(title: Text(viewModel.errorTitle),
                              message: Text(viewModel.errorMessage))
                    })
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }

                Spacer()
                
                HStack {
                    Spacer()
                    if viewModel.isShowMap {
                        MapButtonView(showingSheet: $showingSheet, viewModel: viewModel)
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("Search IP"))
        }
    }
}

#Preview {
    MainView()
}

struct SearchButtonsView: View {
    var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.getGeo()
            }, label: {
                ButtonView(title: "Get Info")
            })
            
            Spacer()
            
            Button(action: {
                viewModel.findMe()
            }, label: {
                ButtonView(title: "Find me")
            })
            
            Spacer()
            
            Button(action: {
                viewModel.reset()
            }, label: {
                ButtonView(title: "Reset")
            })
        }
    }
}

struct SearchField: View {
    @Binding var searchText: String
    @Binding var isTextValid: Bool
    @Binding var textFieldColor: Color
    var viewModel: MainViewModel
    var placeholder: String = "Enter IP"
    private let characterLimit = 15
    let allowedCharacters = "0123456789."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $searchText, onCommit: {
                viewModel.textFieldValidator()
            })
            .keyboardType(.numbersAndPunctuation)
            .accentColor(.gray)
            .frame(height: 30)
            .onReceive(searchText.publisher.collect()) { newValue in
                searchText = String(newValue.prefix(characterLimit))
                let filtered = newValue.filter { allowedCharacters.contains($0) }
                if filtered != newValue {
                    searchText = String(filtered)
                }
            }
        }
        .foregroundColor(.gray)
        .padding(10)
        .background(textFieldColor)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct ButtonView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .frame(width: 100, height: 35)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)), Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.8509803922, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct MapButtonView: View {
    @Binding var showingSheet: Bool
    var viewModel: MainViewModel
    
    var body: some View {
        Button(action: {
            showingSheet.toggle()
        }, label: {
            Text("Map")
                .frame(width: 75, height: 75)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)), Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.8509803922, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
        })
        .sheet(isPresented: $showingSheet) {
            MapView(viewModel: MapViewModel(locationStr: viewModel.location), showingSheet: $showingSheet)
        }
    }
}


