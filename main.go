package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", IPHandle)
	log.Println("server start!")
	http.ListenAndServe(":8080", nil)

}
func IPHandle(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "Hello World")
}
