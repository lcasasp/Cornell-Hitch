//
//  DMView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/23/22.
//

import SwiftUI

struct DMView: View {
    let dms:[Message]
    let username: String
    @State var newMessageBody: String = ""
    var body: some View {
        VStack{
            ScrollView
            {
                ForEach(dms, id: \.hashValue ){ message in
                    if message.user == username{
                        MessageCell(message: message,tag: 1)
                            .listRowSeparator(.hidden)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                    }
                    else{
                        MessageCell(message: message,tag: 2)
                            .listRowSeparator(.hidden)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    
                }
            }
            ZStack(alignment: .bottom)
            {
                
//                Rectangle()
//                    .frame(width: .infinity, height: 40)
                    Color.white
                    
                    
                        .frame(width: 350, height: 40)
                    
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2))
                    Image(systemName: "arrow.up.circle")
                    .font(Font.system(size: 30, weight: .semibold))
                        .offset(x: 140, y:0)
                        
                        .frame(width: 350, height: 40)
                        .background(.black.opacity(0.4))
                        .cornerRadius(15)
                TextField("Enter Message",text: $newMessageBody)
                                    .padding()
                                    .frame(width: 300, height: 40)
                                    
//                                    .background(.blue.opacity(0.4))
                                    .cornerRadius(15)
                                    .offset(x: -25, y:0)
                    
                    
//                    .cornerRadius(1)
                
//                Color.gray
                
//                TextField("Enter Message",text: $newMessageBody)
//                    .padding()
//                    .frame(width: .infinity, height: 40)
//                    .background(.black.opacity(0.4))
//                    .cornerRadius(15)
                    
            }
        }
    }

struct DMView_Previews: PreviewProvider {
    static var previews: some View {
        DMView(dms: [
            Message(user:"Jnm224", timestamp: "12:30 AM", body: """
        Good morning, my name is Josh and I am looking for a ride to Syracuse
        on November 30th. I noticed you're already headed there, do you have any more room?
        """),
            Message(user:"Mwf58", timestamp: "12:35 AM", body:
        """
        Hi Josh.
        Sure, I have room for one more. I plan on leaving at 4 AM on that day, and gas would be $5 per person.
        """),
            Message(user:"Jnm224", timestamp: "12:37 AM", body: """
        Perfect, thanks so much!
        """),Message(user:"Mwf58", timestamp: "12:38 AM", body:
        """
        No problem, let's meet behind RPCC on the day of.
        """)], username:"Jnm224")
            
    
}
        }
        }
