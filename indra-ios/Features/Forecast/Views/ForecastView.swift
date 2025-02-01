//
//  ForecastView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

// ForecastView.swift
import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = ForecastViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading forecasts...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                List(viewModel.forecasts) { forecast in
                    VStack(alignment: .leading) {
                        Text(forecast.name)
                            .font(.headline)
                            .foregroundStyle(.black)
                        
                        // Showing forecast details
                        Text("Email: \(forecast.email)")
                        Text("Phone: \(forecast.phone)")
                        Text("Location: \(forecast.locationName), \(forecast.state)")
                        Text("Gender: \(forecast.gender)")
                        Text("DOB: \(forecast.dob)")
                        Text("Address: \(forecast.address)")
                        Text("PIN: \(forecast.pin)")
                    }
                    .padding()
                }
            }
            
            // Error handling if there's an error in fetching the data
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchForecasts()
            }
        }
        .navigationTitle("Forecasts")
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
