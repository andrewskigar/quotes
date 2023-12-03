package main

import (
    "github.com/go-chi/chi"
    "net/http"
	"quotes/api"
)

func main() {
    r := chi.NewRouter()

    // Mount the quotes API
    r.Mount("/api", api.QuotesAPI())

    http.ListenAndServe(":8080", r)
}
