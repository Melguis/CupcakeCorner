//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Jorge Henrique on 14/06/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    @State private var disabled = true
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(order.hasValidAddress == false || disabled)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(order.$name, perform: { name in
                    validatingWhiteSpaces(name: name,
                                          streetAddress: order.streetAddress,
                                          city: order.city,
                                          zip: order.zip)
                })
                .onReceive(order.$streetAddress, perform: { streetAddress in
                    validatingWhiteSpaces(name: order.name,
                                          streetAddress: streetAddress,
                                          city: order.city,
                                          zip: order.zip)
                })
                .onReceive(order.$city, perform: { city in
                    validatingWhiteSpaces(name: order.name,
                                          streetAddress: order.streetAddress,
                                          city: city,
                                          zip: order.zip)
                })
                .onReceive(order.$zip, perform: { zip in
                    validatingWhiteSpaces(name: order.name,
                                          streetAddress: order.streetAddress,
                                          city: order.city,
                                          zip: zip)
                })
    }
    
    func validatingWhiteSpaces(name: String, streetAddress: String, city: String, zip: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedStreetAddress = streetAddress.trimmingCharacters(in: .whitespaces)
        let trimmedCity = city.trimmingCharacters(in: .whitespaces)
        let trimmedZip = zip.trimmingCharacters(in: .whitespaces)
        
        if trimmedName.isEmpty || trimmedStreetAddress.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            disabled = true
        } else {
            disabled = false
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
