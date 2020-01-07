module Letters
using Random
export randstring
const MY_NAME = "Letters"
function rand()
    Random.rand('A':'Z')
end # function
function randstring()
    [rand() for _ in 1:10] |> join
end # function
include("module_name.jl")
include("Numbers.jl")

end  # module Letters
