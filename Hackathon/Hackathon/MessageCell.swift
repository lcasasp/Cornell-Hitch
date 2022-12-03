//
//  SwiftUIView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/23/22.
//

import SwiftUI

struct MessageCell: View {
    var message: String
    var time: String
    var tag: Int
    var body: some View {
        VStack(alignment: .leading){

                if tag == 1{
                    VStack{
                        ZStack(alignment: .leading) {
                            Text(message ?? "")
                                .frame(maxWidth: 300, alignment: .leading)
                                .padding()
                                .background(.blue.opacity(0.7))
                                .cornerRadius(15)
                        }
                        Spacer()
                            .frame(width: 0, height: 10)
                        Text(time ?? "")
                            .offset(x: -117, y:0)
                    }
                }
                if tag == 2{
                    VStack{
                    ZStack(alignment: .trailing) {
                        Text(message ?? "nil")
                            .frame(maxWidth: 300)
                            .padding()
                            .background(.gray.opacity(0.7))
                            .cornerRadius(15)

                    }
                    Spacer()
                        .frame(width: 0, height: 10)
                    Text(time ?? "nil" )
                        .offset(x: 117, y:0)
                }
                }


                Spacer()
            }
        }
    }

//    struct SwiftUIView_Previews: PreviewProvider {
//        static var previews: some View {
////            MessageCell(message: Message(sender_id:221031446, timestamp: "12:30 AM", body: """
////        Good morning, my name is Josh and I am looking for a ride to Syracuse
////        on November 30th. I noticed you're already headed there, do you have any more room?
////        """), tag:2)
//        }
    


