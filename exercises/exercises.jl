function fizzbuzz(x::Int)
    try
        if (x < 1)
            throw(ArgumentError("Function argument should be greater or equal to 1")) 
        else 
            for i in 1:x
                fizzed = i % 3 == 0 ? "Fizz" : i
                println(fizzed)
            end
        end
    catch err
        showerror(stdout, err)
    end
end

function interest(quantity::Float64, days::Int, rate::Float64)
    try
        if (quantity < 1)
            throw(ArgumentError("initial quantity should be greater or equal than 0")) 
        elseif (days < 1)
            throw(ArgumentError("days should be greater or equal than 0")) 
        elseif (rate < -100)
            throw(ArgumentError("rate can't exceed -100%")) 
        else 
            new_quantity = quantity
            rate = rate / 100
            for day in 1:days
                new_quantity = new_quantity * (1 + rate)
            end
            return new_quantity
        end
    catch err
        showerror(stdout, err)
    end
end

function baselpi(n::Int)
    if n < 1
        throw(ArgumentError("initial quantity should be greater or equal than 1")) 
    end

    basel_sum = 0
    for i in 1:n
        basel_sum += 1 / ( i^2 )
    end

    basel_π = sqrt(6 * basel_sum)
    return basel_π
end

function drawtri(n)
    top_vertex = "o"
    botttom_segment = "o"*"-"^(n)*"o"

    printable = [top_vertex]

    for i in 0:(n-1)
        line = "|"*" "^i*"\\"
        push!(printable, line)
    end

    push!(printable, botttom_segment)


    for line in printable
        println(line)
    end
end

function muxer(l)
    r = []
    sublists_number = length(l)
    sublists_length = length(l) == 0 ? 0 : min(map((sublist)->length(sublist), l)...)
    for i in 1:sublists_length
        for j in 1:sublists_number
           push!(r, l[j][i]) 
        end
    end
    return r
end




function compute_fibonoacci(n)
    fibonacci_sequence = reduce((acc, i) -> [acc..., acc[end-1] + acc[end]] , 1:(n-2), init=[0, 1])
    return fibonacci_sequence
end

function compute_fibonacci_period(k)
    period_length = 0
    fib = [0, 1]
    while period_length == 0
        push!(fib, fib[end-1] + fib[end])
        if length(fib) > 2 && fib[end] % k == 1 && fib[end-1] % k == 0
            period_length = length(fib)-2
        end
    end
    return period_length
end

interest(3.0, 4, 50.0)
interest(0.0, 5, 0.02) # THIS MUST GIVE AN ERROR 
interest(-1.0, 5, 2e-2) # THIS MUST GIVE AN ERROR 
interest(2.3, -3, 1e-3) # THIS MUST GIVE AN ERROR 
interest(100000.0, 30.0, 1e-3) # THIS MUST GIVE AN ERROR 
interest(100000.0, 30, 1) # THIS MUST GIVE AN ERROR 
interest(100000.0, 30, -150.0) # THIS MUST GIVE AN ERROR 

baselpi(1)
baselpi(10)
baselpi(100)
baselpi(1000)
baselpi(1000000)

drawtri(100)

muxer([[1,2,3], [4,5,6], [7,8,9, 0], [10,11,12]])

muxer([[]])

compute_fibonoacci(10)

compute_fibonacci_period(100000)

