import MapKit
import Combine

class LocationSearchManager: NSObject, ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults: [MKLocalSearchCompletion] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = [.address, .pointOfInterest]
        
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] query in
                if !query.isEmpty {
                    self?.searchCompleter.queryFragment = query
                }
            }
            .store(in: &cancellables)
    }
}

extension LocationSearchManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Location search failed with error: \(error.localizedDescription)")
    }
} 