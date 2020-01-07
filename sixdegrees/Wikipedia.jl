module Wikipedia
using HTTP, Gumbo, Cascadia
const RANDOM_PAGE_URL =  "https://en.m.wikipedia.org/wiki/Special:Random"
export fetchrandom, fetchpage, articlelinks
function fetchpage(url)
    response = HTTP.get(url)
    if response.status == 200 && length(response.body) > 0
        String(response.body)
    else
        ""
    end
end
function extractlinks(elem)
 map(eachmatch(Selector("a[href^='/wiki/']:not(a[href*=':'])"), elem)) do
e
 e.attributes["href"]
 end |> unique
end
function fetchrandom(url = RANDOM_PAGE_URL)
    fetchpage(url)
end
function articlelinks(content)
    if ! isempty(content)
        dom = Gumbo.parsehtml(content)
        links = extractlinks(dom.root)
    end
end
end #module Wikipedia
