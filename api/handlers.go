package api

import (
    "encoding/json"
	"github.com/go-chi/chi"
    "net/http"
)

// quotesAPI returns a new Chi router configured with the quotes routes.
func QuotesAPI() chi.Router {
	r := chi.NewRouter()
	r.Get("/quotes", handleQuotes)
	return r
}

// HandleQuotes returns a JSON response with a random quote.
func handleQuotes(w http.ResponseWriter, r *http.Request) {
    quote := GetRandomQuote()

    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    json.NewEncoder(w).Encode(quote)
}
