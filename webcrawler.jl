using HTTP, Gumbo
const PAGE_URL = "http://localhost:8000/"
const LINKS = String[]

function fetchPage(url)
    response = HTTP.get(url)
    # if response.status == 200 && parse(Int, Dict(response.headers)["Content-Length"]) > 0
    #     String(response.body)
    # else
    #     ""
    # end # if
    response.status == 200 && parse(Int, Dict(response.headers)["Content-Length"]) > 0 ? String(response.body) : ""
end # function

function extractlinks(elem)
    if isa(elem, HTMLElement) && tag(elem) == :a && in("href", collect(keys(attrs(elem))))
        url = getattr(elem, "href")
        #startswith(url, "/portfolio/") && push!(LINKS, url)
        startswith(url, "/2019/") && ! occursin(":", url) && push!(LINKS, url)
    end
    for child in children(elem)
        extractlinks(child)
    end
end # function


content = fetchPage(PAGE_URL)
if ! isempty(content)
    dom = Gumbo.parsehtml(content)
    extractlinks(dom.root)
end # if
display(unique(LINKS))
