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
    @State var realDistance:String

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
                    Text("Real Distance=\(realDistance)").frame(width:390,height:45,alignment: .leading)
                }
                HStack{
                    VStack{
                        Button(action: {
                            Task{
                                currentCoordinates = await Helper.shared.getCoordinates(destinationValue: current)
                                
                                destinationCoordinates = await Helper.shared.getCoordinates(destinationValue: destination)
                                
                                distance = String(format:"%.2fkm",Helper.shared.getDistance(currentCoordinates: currentCoordinates, destinationCoordinates: destinationCoordinates))
                                
                                realDistance = await Helper.shared.getRealDistance(currentCoordinates: currentCoordinates, destinationCoordinates: destinationCoordinates)
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
    
    
}

#Preview {
    ContentView(destinationCoordinates: .init(), currentCoordinates:.init(), destination: "", current: "", distance: "", realDistance: "")
}
