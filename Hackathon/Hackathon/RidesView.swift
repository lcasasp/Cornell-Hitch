//
//  RidesView.swift
//  Hackathon
//
//  Created by Josh Magazine on 12/3/22.
//

import SwiftUI

struct RidesView: View {
    @State var rides: [[String]]
    var body: some View {
        VStack{
            ZStack{
                Text("Rides")
                    .font(Font.system(size: 60, weight: .semibold))
            }
            
            ScrollView{
                ForEach(rides.indices, id: \.self) {
                    Text("Ride \($0):")
                    Spacer()
                        .frame(height:15)
                    Text("Destination: \(rides[$0][0])")
                    Text("Date: \(rides[$0][1])")
                    Text("Capacity: \(rides[$0][2])")
                }
                
            }
        }
        }
    }


//struct RidesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RidesView()
//    }
//}
