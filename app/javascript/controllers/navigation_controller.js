import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["nav"]

  connect() {
    this.updateActiveState()
  }

  updateActiveState() {
    const currentPath = window.location.pathname
    const links = this.navTarget.querySelectorAll("a")

    links.forEach(link => {
      const href = link.getAttribute("href")
      const isActive = currentPath === href ||
                       (href !== "/" && currentPath.startsWith(href))

      if (isActive) {
        link.classList.add("nav-item-active")
      } else {
        link.classList.remove("nav-item-active")
      }
    })
  }
}

