const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>'
      + '<td>' + brewery['year'] + '</td>'
      + '<td>' + brewery['active'] + '</td>'
      + '<td>' + brewery['beercount'] + '</td>'
      + '</tr>')
      // console.log(brewery)
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year - b.year
  })
}

BREWERIES.sort_by_active = () => {
  BREWERIES.list.sort((a, b) => {
    return (a.active ? 1 : 0) - (b.active ? 1 : 0)
    // return a.active.localeCompare(b.active);
  })
}

BREWERIES.sort_by_beercount = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beercount - b.beercount
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) {
    return
  }

  $("#name").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_name()
    BREWERIES.show();

  })

  $("#year").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_year()
    BREWERIES.show()
  })

  $("#active").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_active()
    BREWERIES.show()
  })

  $("#beercount").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_beercount()
    BREWERIES.show()
  })

  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.show()
  })
})
