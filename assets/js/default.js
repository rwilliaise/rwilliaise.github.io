
(async () => {

const searchIndex = await fetch("/search_index.json")
  .then(r => r.json())

window.openRandomPage = () => {
  const project = searchIndex[Math.floor(Math.random() * searchIndex.length)]
  window.open(project.url)
}

// totally not copied from a certain outdated site
function createSearchbar(area) {
  let currentFocus = -1

  window.closeAutocompleteLists = (element = undefined) => {
    const items = document.getElementsByClassName("ac-items")
    for (const item of items)
      if (element != item && element != area)
        item.parentNode.removeChild(item)
  }

  area.addEventListener("input", (e) => {
    const value = area.value
    closeAutocompleteLists()

    if (!value) return
    currentFocus = -1

    const list = document.createElement("div")
    list.setAttribute("id", area.id + "ac-list")
    list.setAttribute("class", "ac-items")
    
    area.parentNode.appendChild(list)
    for (const project of searchIndex) {
      const title = `${project.id} - ${project.name}`
      const titleIndex = title 
        .toLowerCase()
        .indexOf(area.value.toLowerCase())
      if (titleIndex == -1) continue
      const item = document.createElement("div")
      item.innerHTML = ""
      if (titleIndex !== 0)
        item.innerHTML += title.slice(0, titleIndex)
      item.innerHTML += `<strong>${title.slice(titleIndex, titleIndex + area.value.length)}</strong>`
      item.innerHTML += `${title.slice(titleIndex + area.value.length)}`
      item.onclick = () => {
        area.value = ""
        window.open(project.url)
        closeAutocompleteLists()
      }
      list.appendChild(item)
    }
  })
}

let onload = () => {
  createSearchbar(document.getElementById("searchbar"))
}
document.onload = onload
if (document.readyState === "complete") {
  onload()
}

document.onclick = (e) => {
  closeAutocompleteLists(e.target)
}


})();

