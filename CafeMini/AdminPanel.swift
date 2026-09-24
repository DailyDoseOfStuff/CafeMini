//
//  AdminPanel.swift
//  CafeMini
//
//  Created by ALLEN LIU on 9/21/26.
//

import SwiftUI

struct AdminPanel: View {

    @Environment(\.dismiss) var dismiss

    @State var password = ""
    @State var unlocked = false

    @State var newName = ""
    @State var newPrice = ""

    @Binding var AdminList: [String: Int]
    @Binding var cart: [String: Int]

    private let adPass = "1234"
    @State var wrongPass = false
    @State var showAlert = false
    @State var goodAlert = false


    var body: some View {
        
        Spacer()
        Spacer()
        
        if unlocked {
            dashboard
        } else {
            lockScreen
        }
        Spacer()
        
//        VStack{
//            HStack{
//                Button{
//                    dismiss()
//                } label: {
//                RoundedRectangle(cornerRadius: 15)
//                        .frame(width: 50, height: 50 )
//                        .foregroundStyle(.thinMaterial)
//                        .overlay(
//                            Image(systemName: "chevron.backward")
//                                .font(.title2)
//                                .foregroundStyle(.black)
//                        )
//                }
//            }
//        }
        
    }

    var lockScreen: some View {
        VStack {
            Image(systemName: "lock.shield")
                .font(.largeTitle)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Unlock") {
                if password == adPass {
                    unlocked = true
                } else {
                    wrongPass = true
                    password = ""
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 70, height: 40)
                    .foregroundStyle(.black)
                    .overlay(
                        Text("Unlock")
                            .foregroundStyle(.blue)
                    )
            )
        }
        .alert(
            "Wrong Password",
            isPresented: $wrongPass,
            actions: {

            }
        )
        .padding()
    }

    var dashboard: some View {
        let names = AdminList.keys.sorted()
        return List {
            Section("Menu") {
                ForEach(names, id: \.self) { name in
                    HStack {
                        Text(name)
                        Spacer()
                        Text("$\(AdminList[name] ?? 0)")
                    }
                }
                .onDelete { offsets in
                    for i in offsets {
                        AdminList.removeValue(forKey: names[i])
                        cart.removeValue(forKey: names[i])
                    }
                }
            }
            Section("Add/Upd Item") {
                TextField("Item Name", text: $newName)
                TextField("Item Price" , text: $newPrice)
                    .keyboardType(.numberPad)
                Button("Update"){
                    let typedName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    var existingName = ""
                    for name in AdminList.keys {
                        if name.lowercased() == typedName.lowercased() {
                            existingName = name
                        }
                    }
                    
                    if typedName.isEmpty {
                        showAlert = true
                    } else if let price = Int(newPrice) {
                        
                        if existingName.isEmpty {
                            AdminList[typedName] = price
                            goodAlert = true
                        } else {
                            AdminList[existingName] = price
                            goodAlert = true
                        }
                        
                        newPrice = ""
                        newName = ""
                        
                    } else {
                        showAlert = true
                    }
                    
                }
                
            }
        }
        .alert("Make sure all fields are filled in correctly", isPresented: $showAlert, actions: {
            
        })
        .alert("Updated", isPresented: $goodAlert, actions: {
            
        })

    }

}

#Preview {
    AdminPanel(AdminList: .constant(["Crossiant": 5]), cart: .constant([:]))
}
