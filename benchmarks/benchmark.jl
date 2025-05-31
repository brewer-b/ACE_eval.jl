using ACE_eval

function enumerate_all()
    num_hands = 0
    start_time = time()
    for a in 1:52
        for b in 1:(a-1)
            for c in 1:(b-1)
                for d in 1:(c-1)
                    for e in 1:(d-1)
                        for f in 1:(e-1)
                            for g in 1:(f-1)
                                @inbounds strength = hand_rank(a,b,c,d,e,f,g)
                                num_hands += 1
                            end
                        end
                    end
                end
            end
        end
    end
    end_time = time()
    elapsed_time = end_time - start_time
    return num_hands, elapsed_time
end

function print_results(benchmark_name, num_hands, elapsed_time)
    println("--- Benchmark Results: $(benchmark_name) ---")
    println("Total hands enumerated: ", num_hands)
    println("Time taken: $(round(elapsed_time, digits=3)) seconds")
    
    hands_per_second = num_hands / elapsed_time
    million_hands_per_second = hands_per_second / 1_000_000

    println("Throughput: $(round(million_hands_per_second, digits=3)) million hands/second")
    println("-------------------------------------------------") 
end

all_hands, all_hands_time = enumerate_all()
print_results("Enumerate all hands", all_hands, all_hands_time)