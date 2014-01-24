Dice::Application.routes.draw do
  get("/", {controller: "dice", action: "new_game"})
  get("/dice", {controller: "dice", action: "roll_dice"})
end
