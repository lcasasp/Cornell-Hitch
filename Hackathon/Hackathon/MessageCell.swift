//
//  SwiftUIView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/23/22.
//

import SwiftUI

struct MessageCell: View {
    var message:Message
    var tag: Int
    var body: some View {
        VStack(alignment: .leading){
                if tag == 1{
                    ZStack(alignment: .leading) {
                        Text(message.body)
                            .frame(maxWidth: 300, alignment: .leading)
                            .padding()
                            .background(.blue.opacity(0.7))
                            .cornerRadius(15)
                            .offset(x: -20, y:0)
                    }
                }
                if tag == 2{
                    
                    ZStack(alignment: .trailing) {
                        Text(message.body)
                            .frame(maxWidth: 300)
                            .padding()
                            .background(.gray.opacity(0.7))
                            .cornerRadius(15)
                            .offset(x: +20, y:0)
                    }
                }
//
                    
                    
        
                Spacer()
            }
        }
    }
    
    struct SwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            MessageCell(message: Message(user:"Jnm224", timestamp: "12:30 AM", body: """
        Good morning, my name is Josh and I am looking for a ride to Syracuse
        on November 30th. I noticed you're already headed there, do you have any more room?
        """), tag:2)
        }
    }
    

