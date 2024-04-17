//
//  ContentView.swift
//  CalculateDistance
//
//  Created by Angelos Staboulis on 17/4/24.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @State var destinationCoordinates:CLLocationCoordinate2D
    @State var currentCoordinates:CLLocationCoordinate2D
    @State var destination:String
    @State var current:String
    @State var distance:String
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("Enter the place you are currently in").frame(width:390,height:45,alignment: .leading)
                    TextField("Enter the place you are currently in", text: $current)
                }
                VStack{
                    Text("Enter the place you want to go").frame(width:390,height:45,alignment: .leading)
                    TextField("Enter the place you want to go",text: $destination)
                }
                VStack{
                    Text("Distance=\(distance)").frame(width:390,height:45,alignment: .leading)
                }
                HStack{
                    VStack{
                        Button(action: {
                            Task{
                                currentCoordinates = await getCoordinates(destinationValue: current)
                                destinationCoordinates = await getCoordinates(destinationValue: destination)
                                distance = String(format:"%.2fkm",getDistance())
                            }
                        }, label: {
                            Text("Go to")
                        })
                    }
                   
                }.frame(width:370,height:45,alignment: .trailing)
            }
            Map{
                    Marker(coordinate: destinationCoordinates) {
                        Text(destination)
                    }
            }.navigationTitle("Calculate Distance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func getCoordinates(destinationValue:String) async -> CLLocationCoordinate2D{
        return await withCheckedContinuation{contiuation in
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(destinationValue) { placermark, error in
                guard let destination = placermark?.last?.location!.coordinate else{
                    return
                }
                contiuation.resume(returning: destination)
            }
        }
       
    }
    func getDistance()->CLLocationDistance{
        let currentLocation = CLLocation(latitude:currentCoordinates.latitude , longitude: currentCoordinates.longitude)
        let destinationLocation = CLLocation(latitude:destinationCoordinates.latitude , longitude: destinationCoordinates.longitude)
        let distance = destinationLocation.distance(from: currentLocation)
        return distance / 1000
    }
}

#Preview {
    ContentView(destinationCoordinates: .init(), currentCoordinates:.init(), destination: "", current: "", distance: "")
}
