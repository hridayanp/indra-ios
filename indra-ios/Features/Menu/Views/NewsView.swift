import SwiftUI

struct NewsView: View {
    @StateObject var viewModel = MenuViewModel()
    @State private var selectedItem: NewsItem? = nil
    @State private var showModal: Bool = false
    @State private var isLoading: Bool = false // To track loading state
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.newsItems) { item in
                    VStack {
                        HStack {
                            // Left section: Main content
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                HStack {
                                    Text(item.date)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    Text("•")
                                        .foregroundColor(.white)
                                    Text(item.author)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                            Spacer()
                            // Right section: Image
                            AsyncImage(url: URL(string: item.imageUrl)) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .padding(.horizontal, 2)
                        .background(Color(hex: "#0B1D29")) // Background color for list items
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedItem = item
                            showModal.toggle()
                            isLoading = true // Start loading the modal
                        }
                        
                        Divider()
                            .frame(height: 2)
                            .background(Color(hex: "#d8d8d8"))
                    }
                }
            }
            .padding()
            .background(Color(hex: "#0B1D29")) // Set the background for the entire NewsView
            .edgesIgnoringSafeArea(.all) // Make sure the background takes up the whole screen
        }
        .onAppear {
            viewModel.loadNewsData() // Load the static data when the view appears
        }
        .sheet(isPresented: $showModal) {
            if let item = selectedItem {
                NewsDetailView(newsItem: item, isLoading: $isLoading)
                    .background(Color(hex: "#0B1D29")) // Ensure the background of the sheet is also the same color
                    .edgesIgnoringSafeArea(.all) // To make sure it takes up the entire modal area
            }
        }
    }
}

struct NewsDetailView: View {
    var newsItem: NewsItem
    @Binding var isLoading: Bool // To track the loading state
    
    var body: some View {
        VStack {
            // Banner image
            AsyncImage(url: URL(string: newsItem.imageUrl)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .padding(.top, 20)
                    .onAppear {
                        // Once image is loaded, stop loading
                        isLoading = false
                    }
            } placeholder: {
                ProgressView()
            }
            
            // Title
            Text(newsItem.title)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.horizontal)
            
            // Scrollable Content (Lorem Ipsum)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Nulla vitae massa. Donec eleifend risus nec augue. Donec aliquet. Vivamus tellus. In ut quam vitae odio lacinia tincidunt. Integer nisi libero, tincidunt at fermentum ut, scelerisque in neque.")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 10)
        }
        .background(Color(hex: "#0B1D29")) // Set background color to hex
        .cornerRadius(15)
        .padding(.horizontal)
        .onAppear {
            isLoading = false // Once sheet is opened, stop loading
        }
    }
}

#Preview {
    NewsView()
}
