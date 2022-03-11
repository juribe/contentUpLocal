import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['listing'];
    static values = { url: String }
    initialize() {
        this.load();
    }
    connect() {
       // this.subscription = consumer.subscriptions.create({ channel: "TasksChannel"},
       // { received: this._received.bind(this) });
    }

    _received(data) {
        this.load();
    }
    delete(){
        alert("delete");
    }
    load() {
        fetch(this.urlValue)
            .then(response => response.text())
            .then(html => this.listingTarget.innerHTML = html)
    }
}