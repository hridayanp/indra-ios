import SwiftUI
import Combine


class MenuViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
   
    
    init() {
        loadNewsData() // Directly load the static data when the view model is initialized
    }
    
    // Load the static news data (no API call)
    func loadNewsData() {
        let data = [
            "category": "technology",
            "data": [
                [
                    "author": "Pragya Swastik",
                    "content": "American actor Aaron Paul, who portrayed Jesse Pinkman in 'Breaking Bad', revealed that he uses a 'credit card-sized dumb phone' that cannot store any apps and can only make calls and send texts. \"There's no camera or emailing,\" Paul said, adding that he's planning to buy a flip phone. \"I haven't owned a computer in over 10 years,\" he added.",
                    "date": "15 Mar 2020,Sunday",
                    "imageUrl": "https://static.getinpix.com/public/images/v1/variants/jpg/m/2020/03_mar/15_sun/img_1584273701082_423.jpg",
                    "readMoreUrl": "https://www.dailymail.co.uk/tvshowbiz/article-8111761/Breaking-Bad-star-Aaron-Paul-reveals-owned-computer-decade-prefers-FLIP-PHONE.html?utm_campaign=fullarticle&utm_medium=referral&utm_source=inshorts ",
                    "time": "06:17 pm",
                    "title": "I use a 'dumb phone' that only makes calls & sends texts: 'Breaking Bad' actor",
                    "url": "https://www.inshorts.com/en/news/i-use-a-dumb-phone-that-only-makes-calls-sends-texts-breaking-bad-actor-1584276455594"
                ],
                [
                    "author": "Pragya Swastik",
                    "content": "Google recently shared five basic protective measures against coronavirus that can be followed by people worldwide. These include washing hands often, coughing into the elbow, not touching the face, staying over three feet apart from others and staying at home on feeling sick. Google engineers are also building a website to screen potential coronavirus patients in the US.",
                    "date": "16 Mar 2020,Monday",
                    "imageUrl": "https://static.getinpix.com/public/images/v1/variants/jpg/m/2020/03_mar/15_sun/img_1584292734587_739.jpg",
                    "readMoreUrl": "https://twitter.com/Google/status/1238893403821113344?s=20&utm_campaign=fullarticle&utm_medium=referral&utm_source=inshorts ",
                    "time": "07:00 am",
                    "title": "Google shares 5 basic protective measures against coronavirus",
                    "url": "https://www.inshorts.com/en/news/google-shares-5-basic-protective-measures-against-coronavirus-1584322241969"
                ]
            ],
            "success": true
        ] as [String : Any]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let response = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
            
            // Directly update the view model with the decoded news items
            self.newsItems = response.data
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = "Failed to load static news data"
        }
    }
    
    
    
    
}
