module ACE_eval

export hand_rank, hand_category

using ACE_eval_jll, PlayingCards
import Base.@propagate_inbounds

ACE_makecard(i) = 1<<(2*(i%13)+6)|1<<(i÷13)

@propagate_inbounds function ACE_addcard(h,c::UInt32) 
     h[(c&7) + 1] += c
     h[3 + 1]|=c 
end

ACE_index(i) = ((i-1) ÷ 4) + ((i-1) % 4) * 13

const deck = UInt32[ACE_makecard(ACE_index(i)) for i=1:52]

# Pad 64 bytes after each 7 card hand
const hands = [zeros(UInt32, 23) for i=1:Threads.nthreads()]

@propagate_inbounds function hand_rank(a,b,c,d,e,f,g)
    thread = Threads.threadid()
    hand = hands[thread]
    fill!(hand, 0)
    ACE_addcard(hand, deck[a])
    ACE_addcard(hand, deck[b])
    ACE_addcard(hand, deck[c])
    ACE_addcard(hand, deck[d])
    ACE_addcard(hand, deck[e])
    ACE_addcard(hand, deck[f])
    ACE_addcard(hand, deck[g])
    return @ccall libACE_eval.E(hand::Ptr{UInt32})::UInt32
end

@propagate_inbounds hand_rank(a::Card,b::Card,c::Card,d::Card,e::Card,f::Card,g::Card) =
                        hand_rank(a.val,b.val,c.val,d.val,e.val,f.val,g.val)

const categories = [
    "High Card",
    "One Pair",
    "Two Pair",
    "Three of a Kind",
    "Straight",
    "Flush",
    "Full House",
    "Four of a Kind",
    "Error",
    "Straight Flush"  
]

function hand_category(rank::UInt32)
    cat = rank >> 28
    return categories[cat + 1]
end

end # module ACE_eval
