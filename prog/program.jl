J0 = Float64(0.7651976866)
J1 = Float64(0.4400505857)

prop1 = [0.7651976866, 0.4400505857, 0.114903484931900, 0.019563353982668405, 0.002476638964109, 
        0.000249757730211234, 2.09383380023e-5, 1.50232581743680821e-6, 9.42234417260450054e-8,
        5.24925017991187e-9, 2.6306151236874532e-10, 1.1980067463031370e-11, 4.999718179448405289e-13, 1.92561676448017289036e-14, 6.8854082000442258385910e-16, 2.29753153221034444e-17, 7.1863965868074928286e-19, 2.11537556805326134e-20, 5.880344573595758340e-22, 1.5484784412116534205e-23, 3.8735030085246577189147e-25, 9.227621982096670229e-27,
        2.0982239559437773488e-28, 4.563424055950105648e-30, 9.5110979327124938e-32,
        1.902951751891382e-33, 3.66082674441680295e-35, 6.781552053554111228e-37, 
        1.211364502417112392e-38, 2.089159981718168173218e-40, 3.4828697942514829e-42]
        
Ji1 = zeros(0)
append!(Ji1, J0)
append!(Ji1, J1)

#funkcja zwracająca błąd bezwzględny
function err(x, val)
    return abs(x - val) / abs(val)
end

#funkcja wypisująca błąd bezwzględny dla tablicy przyblizeń
function print_err(A, n)
    for i in 1:1:(n + 1)
        @show err(A[i], prop1[i])
    end
end

#funkcja wypisująca tablicę
function print_array(A, n)
    for i in 1:1:(n + 1)
        @show A[i]
    end
end

#funkcja wypełniająca tablicę Ji1 przy pomocy rekurencji w przód
function fill_Ji1(x)
    for i in 2:1:20
        next = (((Float32(2.0) * Float32(Float32(i) - Float32(1.0))) / Float32(x)) * Float32(Ji1[i])) - Float32(Ji1[i - 1])
        append!(Ji1, next)
    end
end

function fill_Ji2(x)
    for i in 2:1:20
        next = (((BigFloat(2.0) * BigFloat(BigFloat(i) - BigFloat(1.0))) / BigFloat(x)) * BigFloat(Ji1[i])) - BigFloat(Ji1[i - 1])
        append!(Ji1, next)
    end
end

println("Rekurencja w przod Float32")
fill_Ji1(Float32(1.0))
print_array(Ji1, 20)
print_err(Ji1, 20)

C25 = zeros(0)
C30 = zeros(0)

#funkcja wypełniająca tablicę C25 algorytmem Millera dla N = 25
function fill_C25(x)
    for i in 1:1:27
        append!(C25, Float64(0.0))
    end
    C25[27] = 0.0
    C25[26] = 1.0

    for i in 24:-1:0
        next = (((Float32(2.0) * Float32(i + Float32(1.0))) / x) * Float32(C25[i + 2])) - 
        Float32(C25[i + 3])
        C25[i + 1] = next
    end
    λ = J0 / C25[1]
    for i in 1:1:26
        C25[i] = C25[i] * λ
    end 
end

function fill_C25_2(x)
    for i in 1:1:27
        append!(C25, Float64(0.0))
    end
    C25[27] = 4.1
    C25[26] = 2.1

    for i in 24:-1:0
        next = (((Float32(2.0) * Float32(i + Float32(1.0))) / x) * Float32(C25[i + 2])) - 
        Float32(C25[i + 3])
        C25[i + 1] = next
    end
    λ = J0 / C25[1]
    for i in 1:1:26
        C25[i] = C25[i] * λ
    end 
end

#funkcja wypełniająca tablicę C30 algorytmem Millera dla N = 30
function fill_C30(x)
    for i in 1:1:32
        append!(C30, Float64(0.0))
    end
    C30[32] = 0.0
    C30[31] = 1.0

    for i in 29:-1:0
        next = (((Float32(2.0) * Float32(i + Float32(1.0))) / x) * Float32(C30[i + 2])) - 
        Float64(C30[i + 3])
        C30[i + 1] = next
        @show next
    end
    λ = J0 / C30[1]
    for i in 1:1:31
        C30[i] = C30[i] * λ
    end 
end

function fill_C30_2(x)
    for i in 1:1:32
        append!(C30, Float64(0.0))
    end
    C30[32] = 0.0
    C30[31] = 1.0

    for i in 29:-1:0
        next = (((Float64(2.0) * Float64(i + Float64(1.0))) / x) * Float64(C30[i + 2])) - 
        Float64(C30[i + 3])
        C30[i + 1] = next
        @show next
    end
    λ = J0 / C30[1]
    for i in 1:1:31
        C30[i] = C30[i] * λ
    end 
end

println("\nAlgorytm Millera")
println("N = 25")
fill_C25(Float32(1.0))
print_array(C25, 25)
print_err(C25, 25)

println("\nN = 25, inne wartości początkowe")
fill_C25_2(Float32(1.0))
print_array(C25, 25)
print_err(C25, 25)

println("\nN = 30 Float32")
fill_C30(Float32(1.0))
print_array(C30, 30)
print_err(C30, 30)

C30 = zeros(0)
println("\nN = 30 Float64")
fill_C30_2(Float64(1.0))
print_array(C30, 30)
print_err(C30, 30)

setprecision(256);
Ji1 = zeros(0)
append!(Ji1, J0)
append!(Ji1, J1)
println("\nRekurencja w przod BigFloat - 256bit")
fill_Ji2(BigFloat(1.0))
print_array(Ji1, 20)
print_err(Ji1, 20)
