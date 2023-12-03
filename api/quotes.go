package api

import (
    "encoding/json"
    "io/ioutil"
    "math/rand"
    "time"
)

// Quote represents a quote structure.
type Quote struct {
    Philosopher string `json:"philosopher"`
    Quote       string `json:"quote"`
}

// GetRandomQuote returns a random quote from the top 100 quotes.
func GetRandomQuote() Quote {
    quotes := loadQuotes()
    rand.Seed(time.Now().UnixNano())
    randomIndex := rand.Intn(len(quotes))
    return quotes[randomIndex]
}

func loadQuotes() []Quote {
    file, _ := ioutil.ReadFile("quotes/quotes.json")
    var quotes []Quote
    json.Unmarshal(file, &quotes)
    return quotes
}
