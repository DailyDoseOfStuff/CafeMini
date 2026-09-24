//
//  ContentView.swift
//  CafeMini
//
//  Created by ALLEN LIU on 9/18/26.
//

import SwiftUI

struct ContentView: View {

    
    @State var price: [String: Int] = ["Croissant" : 5,"Chocolate Muffin": 5, "Chocolate Cake" : 8, "Dark Coffee": 5, "Tirimisu": 10]

    @State var Cart: [String: Int] = [:]

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to the Cafe")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 350, height: 75)
                            .foregroundStyle(.thinMaterial)
                            .padding()
                    )
                    .padding(30)

               
                HStack{
                    
                    
                    
                    NavigationLink{
                            CartView(CartDict: $Cart, Prices: $price)
                    } label: {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 30, height: 30)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 40, height: 40)
                            )

                    }
                    
                    Spacer()
                        .frame(width: 50)
                    
                    Text("Item Menu")
                        .bold()
                        .font(.title)
                    
                    Spacer()
                        .frame(width: 50)
                    
                    NavigationLink{
                        AdminPanel(AdminList: $price, cart: $Cart)
                    } label: {
                        Image(systemName: "gear.circle")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 30, height: 30)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 40, height: 40)
                            )

                    }
                }
                .padding(.horizontal,4)
                
                ScrollView(.vertical) {
                    VStack(alignment: .center) {
                        ForEach(price.keys.sorted(), id: \.self) { item in

                            RoundedRectangle(cornerRadius: 25)
                                .fill(.bar)
                                .frame(width: 350, height: 100)
                                .overlay(
                                    
                                    HStack{
                                        Text("\(item)")
                                            .foregroundStyle(.black)
                                            .font(.title)
                                            .bold()
                                        Spacer()
                                        Button(action:{
                                           Cart[item] = (Cart[item] ?? 0) + 1
                                            print(Cart)
                                        }){
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(.thinMaterial)
                                                .frame(width: 50, height: 50)
                                                .overlay(
                                                    Image(systemName: "plus.square")
                                                        .resizable()
                                                        .foregroundStyle(.black)
                                                )
                                        }
                                    }
                                        .padding(.horizontal)
                                )
                        }
                    }
                    .padding(33)

                }
                .frame(width: 375, height: 600)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 375, height: 600)
                        .foregroundStyle(.thinMaterial)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))

               
                    
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.brown)
        }
    }
}

#Preview {
    ContentView()
}
