using ACE_eval
using Test

@testset "ACE_eval.jl" begin

@test hand_category(hand_rank(1,2,3,4,5,6,7)) == "Four of a Kind" 

end