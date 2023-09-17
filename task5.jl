using HorizonSideRobots
r = Robot(animate=true)

function mark_perimeters!(r)
    go_sud!(r)
    go_west!(r)
    mark_outer!(r)
    mark_inner!(r) 
end

function mark_inner!(r)
    while !isborder(r, Nord)
        move!(r, Nord)
        side = Ost
        while !ismarked(r)
            if !isborder(r, side)
                move!(r, side)
            else
                # problem with definition of side, where robot find inner_border, need to consider 2 cases
                for inner_side in [Nord, Ost, Sud, West]
                    while isborder(r, inner_side)
                        mark(r)
                        move!(r, Nord)
                    end
        end
        side = inverseSide()
    end
end

function mark_outer!(r)
    for side in [Nord, Ost, Sud, West]
        mark_along!(r, side)
    end
end

function mark_along!(r, side)
    while !isborder(r, side)
        mark(r)
        move!(r, side)
    end
end

function go_sud!(r)
    n_steps_sud = 0
    while !isborder(r, Sud)
        move!(r, Sud)
        n_steps_sud += 1
    end
    return n_steps_sud
end

function go_west!(r)
    n_steps_west = 0
    while !isborder(r, West)
        move!(r, West)
        n_steps_west += 1
    end
    return n_steps_west
end