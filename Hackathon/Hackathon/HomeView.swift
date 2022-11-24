//
//  HomeView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/22/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var username: String
    @Binding var password: String
    var body: some View {
        NavigationStack{
            VStack{
                ZStack(alignment: .top)
                {
                    Color.green
                        .ignoresSafeArea()
                    Text("Dashboard")
                        .foregroundColor(.black)
                        .padding()
                        .font(.system(size: 60, design: .monospaced))
                    Spacer()    
                    ZStack{
                        Text("Welcome, " + username + "!")
                            .foregroundColor(.black)
                            .padding()
                            .font(.system(size: 60, design: .monospaced))
                        
                    }
                }
                ZStack
                {
                    Color.yellow
                        .ignoresSafeArea()
                    
                    
                }
                ZStack(alignment: .bottom)
                {
                    Color.black
                        .frame(width:80,height:10)
                        
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(username: , password: <#T##Binding<String>#>)
//    }
//}
