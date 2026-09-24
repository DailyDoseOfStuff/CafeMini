import SwiftUI

struct CartView: View {
    @Binding var CartDict: [String: Int]
    @Binding var Prices: [String: Int]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    dismiss()
                } label: {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.thinMaterial)
                        .overlay(
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 30)
                                .foregroundStyle(.black)
                        )
                }
                .padding()

                Spacer()

                Text("Cart")
                    .bold()
                    .font(.largeTitle)
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 100, height: 50)
                            .foregroundStyle(.thinMaterial)
                    }

                Spacer()
                Spacer()
            }

            ScrollView {
                VStack(alignment: .center) {
                    ForEach(CartDict.sorted(by: { $0.key < $1.key }), id: \.key) { entry in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.bar)
                            .frame(width: 350, height: 100)
                            .overlay(
                                HStack {
                                    Text(entry.key)
                                        .foregroundStyle(.black)
                                        .font(.title)
                                        .bold()

                                    Spacer()

                                    Button {
                                        CartDict[entry.key, default: 0] -= 1
                                        if CartDict[entry.key] == 0 {
                                            CartDict.removeValue(forKey: entry.key)
                                        }
                                    } label: {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(.thinMaterial)
                                            .frame(width: 30, height: 30)
                                            .overlay(
                                                Image(systemName: "minus.square")
                                                    .resizable()
                                                    .foregroundStyle(.black)
                                            )
                                    }

                                    Text("\(entry.value)")

                                    Button {
                                        CartDict[entry.key, default: 0] += 1
                                    } label: {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(.thinMaterial)
                                            .frame(width: 30, height: 30)
                                            .overlay(
                                                Image(systemName: "plus.square")
                                                    .resizable()
                                                    .foregroundStyle(.black)
                                            )
                                    }
                                }
                                .padding(.horizontal)
                            )
                            .padding(1)
                    }
                }
                .padding(34)
            }
            .frame(width: 375, height: 600)
            .background(RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.thinMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 20))

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(red: 229/255, green: 170/255, blue: 112/255))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CartView(CartDict: .constant(["Croissant": 5, "Pineapple": 4]), Prices: .constant(["Croissant": 5]))
}
