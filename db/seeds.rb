5.times do 
    Message.create({
        from: Faker::Military.air_force_rank,
        body: Faker::Game.genre,
        title: Faker::Food.description,
        to:   Faker::Food.dish,
    })
end