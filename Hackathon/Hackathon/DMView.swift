//
//  DMView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/23/22.
//

import SwiftUI

struct DMView: View {
//    @Binding var dms:[Message] 
    let sender_id: Int = 221031446
    let recipient_id: Int = 112031839
    @State var newMessageBody: String = ""
    @State var messages : [String] = []

    var body: some View {
        
        VStack{
            Text("Messages")
                .font(Font.system(size: 60, weight: .semibold))
        
            //        }
            Spacer()
                .frame(height: 20)
            ScrollView(.vertical, showsIndicators: true){
                VStack{
                    ForEach(messages.indices, id: \.self) {
                        
                        MessageCell(message: messages[$0], time: "Now", tag: 1)
                            .listRowSeparator(.hidden)
                            .padding(.trailing, 20)
                        
                    }
                }
            }
            
            
            
            
            ZStack(alignment: .bottom)
            {
                
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
                    .cornerRadius(20)
                    .onTapGesture {
                        messages += [newMessageBody]
                    }
                TextField("Enter Message",text: $newMessageBody)
                    .padding()
                    .frame(width: 300, height: 40)
                
                
                    .cornerRadius(15)
                    .offset(x: -25, y:0)
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
}
    




//struct DMView_Previews: PreviewProvider {
//    static var previews: some View {
//        DMView(dms: [
//            Message(id: 0, time: "12:30 AM", text: """
//        Good morning, my name is Josh and I am looking for a ride to Syracuse
//        on November 30th. I noticed you're already headed there, do you have any more room?
//        """, sender: 221031446, recipient:112031839),
//            Message(id:1, time: "12:35 AM", text:
//        """
//        Hi Josh.
//        Sure, I have room for one more. I plan on leaving at 4 AM on that day, and gas would be $5 per person.
//        """, sender: 221031446, recipient:112031839),
//            Message(id: 2, time: "12:37 AM", text: """
//        Perfect, thanks so much!
//        """, sender: 221031446, recipient:112031839),Message(id:3, time: "12:38 AM", text:
//        """
//        No problem, let's meet behind RPCC on the day of.
//        """, sender: 221031446, recipient:112031839)])
//
//
//        }
//    }
