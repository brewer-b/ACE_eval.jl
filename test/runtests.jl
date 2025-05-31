using ACE_eval
using Test
using PlayingCards

@testset "ACE_eval.jl" begin

straight_flush_hand = [Card("As"), Card("Ks"), Card("Qs"), Card("Js"), Card("Ts"), Card("2c"), Card("3h")]
four_of_a_kind_hand = [Card("As"), Card("Ah"), Card("Ad"), Card("Ac"), Card("2c"), Card("3h"), Card("4s")]
full_house_hand = [Card("As"), Card("Ah"), Card("Ad"), Card("Ks"), Card("Kh"), Card("2c"), Card("3h")]
flush_hand = [Card("As"), Card("Ks"), Card("Qs"), Card("Js"), Card("4s"), Card("7h"), Card("2d")]
straight_hand = [Card("As"), Card("Ks"), Card("Qs"), Card("Js"), Card("Th"), Card("2c"), Card("3d")]
wheel_hand = [Card("As"), Card("Ah"), Card("Ad"), Card("2s"), Card("3c"), Card("4h"), Card("5d")]
three_of_a_kind_hand = [Card("As"), Card("Ah"), Card("Ad"), Card("2s"), Card("3c"), Card("4h"), Card("Td")]
two_pair_hand = [Card("As"), Card("Ah"), Card("Ks"), Card("Kh"), Card("2c"), Card("3d"), Card("4s")]
one_pair_hand = [Card("As"), Card("Ah"), Card("Ks"), Card("Qh"), Card("2c"), Card("3d"), Card("4s")]
high_card_hand = [Card("As"), Card("Kh"), Card("Qc"), Card("Jd"), Card("9s"), Card("2h"), Card("3c")]

@test hand_category(hand_rank(straight_flush_hand...)) == "Straight Flush"
@test hand_category(hand_rank(four_of_a_kind_hand...)) == "Four of a Kind"
@test hand_category(hand_rank(full_house_hand...)) == "Full House"
@test hand_category(hand_rank(flush_hand...)) == "Flush"
@test hand_category(hand_rank(straight_hand...)) == "Straight"
@test hand_category(hand_rank(wheel_hand...)) == "Straight"
@test hand_category(hand_rank(three_of_a_kind_hand...)) == "Three of a Kind"
@test hand_category(hand_rank(two_pair_hand...)) == "Two Pair"
@test hand_category(hand_rank(one_pair_hand...)) == "One Pair"
@test hand_category(hand_rank(high_card_hand...)) == "High Card"

@test hand_rank(straight_flush_hand...) > hand_rank(four_of_a_kind_hand...)
@test hand_rank(four_of_a_kind_hand...) > hand_rank(full_house_hand...)
@test hand_rank(full_house_hand...) > hand_rank(flush_hand...)
@test hand_rank(flush_hand...) > hand_rank(straight_hand...)
@test hand_rank(straight_hand...) > hand_rank(three_of_a_kind_hand...)
@test hand_rank(three_of_a_kind_hand...) > hand_rank(two_pair_hand...)
@test hand_rank(two_pair_hand...) > hand_rank(one_pair_hand...)
@test hand_rank(one_pair_hand...) > hand_rank(high_card_hand...)

one_pair_higher_kicker = [Card("As"), Card("Ah"), Card("Kd"), Card("Qc"), Card("2s"), Card("3h"), Card("4c")]
one_pair_lower_kicker = [Card("As"), Card("Ah"), Card("Jd"), Card("Qc"), Card("2s"), Card("3h"), Card("4c")]
@test hand_rank(one_pair_higher_kicker...) > hand_rank(one_pair_lower_kicker...)

higher_straight = [Card("Ks"), Card("Qs"), Card("Js"), Card("Ts"), Card("9h"), Card("2c"), Card("3d")]
lower_straight = [Card("Qs"), Card("Js"), Card("Ts"), Card("9h"), Card("8d"), Card("2c"), Card("3s")]
@test hand_rank(higher_straight...) > hand_rank(lower_straight...)

two_pair_higher_top = [Card("Ks"), Card("Kh"), Card("Js"), Card("Jc"), Card("Ah"), Card("2c"), Card("3d")]
two_pair_lower_top = [Card("Qs"), Card("Qh"), Card("Js"), Card("Jc"), Card("Ah"), Card("2c"), Card("3d")]
@test hand_rank(two_pair_higher_top...) > hand_rank(two_pair_lower_top...)

end