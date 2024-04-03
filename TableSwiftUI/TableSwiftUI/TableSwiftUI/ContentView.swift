//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Alexander, Marcus J on 4/1/24.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Student Rec", court: "Indoor", lat: 29.888765, long: -97.950776, imageName: "rec"),
    Item(name: "Gold's Gym", court: "Indoor", lat: 29.885946, long: -97.923632, imageName: "golds"),
    Item(name: "Copper Beech", court: "Blacktop", lat: 29.900624, long: -97.912694, imageName: "copper"),
    Item(name: "The Retreat", court: "Blacktop", lat: 29.894748, long: -97.960970, imageName: "retreat"),
    Item(name: "San Mo Activity Center", court: "Indoor", lat: 29.884898, long: -97.932802, imageName: "activity")
]
struct Item: Identifiable {
        let id = UUID()
        let name: String
        let court: String
        let lat: Double
        let long: Double
        let imageName: String
    }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.884898, longitude: -97.932802), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    
    
    var body: some View {
        NavigationView {
        VStack {
                   List(data, id: \.name) { item in
                       NavigationLink(destination: DetailView(item: item)) {
                       HStack {
                           Image(item.imageName)
                               .resizable()
                               .frame(width: 50, height: 50)
                               .cornerRadius(10)
                       VStack(alignment: .leading) {
                               Text(item.name)
                                   .font(.headline)
                               Text(item.court)
                                   .font(.subheadline)
                           }
                       } // end HStack
                       } // end NavigationLink
                   } // end List
            
Map(coordinateRegion: $region, annotationItems: data) { item in
MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
    Image(systemName: "mappin.circle.fill")
        .foregroundColor(.red)
         .font(.title)
         .overlay(
         Text(item.name)
             .font(.subheadline)
             .foregroundColor(.black)
             .fixedSize(horizontal: true, vertical: false)
             .offset(y: 25)
        )
        }
} // end map
.frame(height: 300)
.padding(.bottom, -30)
            
} // end VStack
    .listStyle(PlainListStyle())
    .navigationTitle("San Marcos Courts")
    } // end NavigationView
    } // end body
} // end ContentView

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    
        let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                Text("Court Type: \(item.court)")
                    .font(.subheadline)
                    .font(.subheadline)
                    .padding(10)
                // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

    Map(coordinateRegion: $region, annotationItems: [item]) { item in
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(.red)
                .font(.title)
                .overlay(
                    Text(item.name)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fixedSize(horizontal: true, vertical: false)
                        .offset(y: 25)
                        )
                 }
                 } // end Map
                     .frame(height: 300)
                     .padding(.bottom, -30)
                   
                    } // end VStack
                     .navigationTitle(item.name)
                     Spacer()
            
         } // end body
      } // end DetailView

#Preview {
    ContentView()
}
              
