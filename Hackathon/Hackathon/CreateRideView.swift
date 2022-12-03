//
//  CreateRideView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/28/22.
//

import SwiftUI

struct CreateRideView: View {
    @State var destination: String = ""
    @State var date: String = ""
    @State var hostuser_id: Int = 0
    @State var user: String 
    @State var capacity: Int = 0
    @State var capacity_str: String = ""
    @State var message: String = ""
    @State var increment: Int = 0
    @State var rides: [[String]] = []
    var body: some View {
        let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
        
        VStack{
            ZStack{
                Color.black.opacity(0.6)
                    .clipShape(Capsule())
                    .frame(width: 400, height: 60)
                    .offset(y:-40)
                HStack(alignment:.center){
                    
                    Text("Create a ride")
                        .foregroundStyle(.green.gradient)
                        .bold(true)
                    
                    ZStack{
                        Text("Rides")
                            .foregroundStyle(.blue.gradient)
                        NavigationLink(destination: RidesView(rides:rides)) {
                                    Text("     ")
                                }
                    }
                    
                    ZStack{
                        Text("Messages")
                            .foregroundStyle(.purple.gradient)
                        NavigationLink(destination: DMView()) {
                                    Text("       ")
                                }
                    }
                        
                    
                }
                .offset(y:-40)
            }
           
            Text("Welcome \(user)")
                .fontWeight(.bold)
                .font(.system(size: 20, design: .rounded))
            
                .offset(x:0, y:0)
                
            Text("Create a Ride")
                .fontWeight(.bold)
                .font(.title)
            
                .offset(x:0, y:0)
            ZStack{
                Image("Background 2")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 300, height:300)
                    .offset(x:0, y:0)
                ZStack(alignment: .center){
                    Image(systemName: "car.fill")
                        .font(.system(size: 180))
                }
            }
            
            ZStack{
                Color.gray.opacity(0.4)
                    .frame(width: 350, height: 60)
                    .clipShape(Capsule())
                TextField("Enter Destination", text: $destination)
                    .padding(.leading, 60)
            }
            
            ZStack{
                Color.gray.opacity(0.4)
                    .frame(width: 350, height: 60)
                    .clipShape(Capsule())
                TextField("Enter Expected Date of Departure", text: $date)
                    .padding(.leading, 60)
            }
            
            ZStack{
                
                Color.gray.opacity(0.4)
                    .frame(width: 350, height: 60)
                    .clipShape(Capsule())
                ZStack(alignment:.leading){
                    Text("Enter rider amount (excl. you")
                        .foregroundColor(.gray)
                        .offset(x:-45, y:0)
                }
                
                ZStack{
                    Picker("Capacity", selection: $capacity) {
                        ForEach(0 ..< 10) {
                            if 0 < $0 && $0 < 1{
                                Text("\($0) rider")
                            }
                            if $0 == 0
                            {
                                Text("      ")
                            }
                            else{
                                Text("\($0) riders")
                
                            }
                        }
                    }
                }
                .offset(x:110, y:0)
                
            }
            VStack{
                ZStack{
                    Image("Background 2")
                        .resizable()
                        .clipShape(Capsule())
                        .frame(width:140,height:50)
                        .onTapGesture {
                            if destination != ""{
                                NetworkManager.createRide(hostuser_id: hostuser_id, date: date, destination: destination, capacity: capacity)
                                var a = date
                                var b = destination
                                capacity_str = "\(capacity)"
                                var c = capacity_str
                                rides += [[a,b,c]]
                                message = "Your ride to \(b) on \(a) accomodating \(c) people has been posted! \(rides)"
                                date = ""
                                destination = ""
                                capacity_str = ""
                                
                                print(rides)
                            }
                        
                            
                        }
                    Text("Create Ride")
                }
                .offset(x:0, y: 10)
                
                Text("\(message)")
                    .onReceive(timer) { input in
                                if increment < 24{
                                    increment += 1
                              
                                }
                                else{
                                    message = ""
                                    increment = 0
                                    
                                }
                                        }
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
        
}


struct CreateRideView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRideView(user: "Josh")
    }
}
