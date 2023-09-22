# I like to get famliar with new languages coding the most classic example from 
# any computational physics course:
# 2D Ising model Monte Carlo simulation using the Metropolis algorithm
# ref: http://phd.fisica.unimi.it/assets/Comp_Phys-esercizio3-1.pdf

using Random
using Images, GLMakie


function flip_spin(spin::Float64)
    return -spin
end

function generate_grid(grid_size::Int)
    return (rand(0:1, grid_size, grid_size) .- 0.5).*2
end

function random_coordinate(grid_size::Int64)
    return rand(1:grid_size, 2)::Vector{Int64}
end

function with_boundary_conditions(coordinate::Vector{Int64}, grid_size::Int64)
    x = coordinate[1] == 0 ? grid_size : coordinate[1] == grid_size + 1 ? 1 : coordinate[1]
    y  = coordinate[2] == 0 ? grid_size : coordinate[2] == grid_size + 1 ? 2 : coordinate[2]
    return [x, y]
end

function compute_coordinate_NNs(coordinate::Vector{Int64}, grid_size::Int64)
    x = coordinate[1]
    y = coordinate[2]

    raw_NN_coordinates = [[x+1, y], [x-1, y], [x, y+1], [x, y-1]]
    return map(NN_coordinate -> with_boundary_conditions(NN_coordinate, grid_size), raw_NN_coordinates)
end

grid_size = 100
β = 1e8
J = -1
B = 0

steps = 1e6

grid = generate_grid(grid_size)

img = Observable(grid)

imgplot = image(@lift(rotr90($img)), axis = (aspect=DataAspect(),), figure = (figure_padding=0, resolution=size(img[])), interpolate=false)

hidedecorations!(imgplot.axis)

display(imgplot)


for step in 1:steps
    println("cycle $step")
    current_coordinate::Vector{Int64} = random_coordinate(grid_size)
    nearest_neighouors = compute_coordinate_NNs(current_coordinate, grid_size)
    nearest_neighouors_spins = map(coordinate->grid[coordinate...], nearest_neighouors)
    current_spin = grid[current_coordinate...]
    flipped_spin = flip_spin(current_spin)
    r = rand(Float64)
    ω = exp(−2*β*(B*flipped_spin+J*flipped_spin*sum(nearest_neighouors_spins)))
    if r <= ω
        grid[current_coordinate...] = flipped_spin 
    end   
    img[] = grid
end












