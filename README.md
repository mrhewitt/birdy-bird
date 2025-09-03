# 20 Game Challenge : Birdy-Bird

Game #1 in my attempt at the [20 game challenge](https://20_games_challenge.gitlab.io/challenge/) - Flappy Bird clone

See it in action on Itch.io:  [Birdy-Bird](https://daddio-dragonslayer.itch.io/birdy-bird)

<p align="center">
  <img height="320" src="https://res.cloudinary.com/dbgabg3vb/image/upload/Birdy_Bird_2025_09_03_11_56_41_t0a4zu.png" />
  <img height="320" src="https://res.cloudinary.com/dbgabg3vb/image/upload/Birdy_Bird_2025_09_03_11_57_37_pgjcc4.png" />
  <img height="320" src="https://res.cloudinary.com/dbgabg3vb/image/upload/Birdy_Bird_2025_09_03_11_57_45_qfvwmp.png" />
</p>

I have since looked at code for a couple of other Flappy Bird 20 Challenge games, and see mine differs in:
1. I used a NinePatchRect which I scale to size of the obstacle, as opposed to making a large sprite the is offet to fit screen. 
2. Instead of moving every object on screen and keeping bird static, I add a camera that followed ahead of the bird but locked on Y-axis, I felt this was a better approach as it meant I would not have to synconize movement every time I wanted to expand game adding say pickups, etc, and left door open to effects like camera shake etc

I added a fairly crude bump effect using camera zoom on collision to illustrate why I think the camera method if good.


## What is the 20 game challenge?

[The 20 Games Challenge](https://20_games_challenge.gitlab.io/how/)

> The goal of the 20 games challenge is to gradually learn more about game development through a series of small projects.
> At the end of the challenge, you should be comfortable creating games in your engine of choice without a tutorial.


## Credits

Music: Dancing Robot / Casual Game Music Pack Vol. 3
https://zakiro101.itch.io/casual-game-music-pack-vol-3

Graphic Assets: Craftpix - Birdy-bird
https://craftpix.net/product/birdy-bird-game-assets


## Assets

Unfortuantly assets are not available for this project as they are from my CraftPix subscription and the licence prohibits me from distributing them outside of a game build
