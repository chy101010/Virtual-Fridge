# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CookingApp.Repo.insert!(%CookingApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CookingApp.Repo
alias CookingApp.Ingredients.Ingredient

defmodule CookingApp.Seeds do
  def store_it(row) do
    roww = elem(row, 1)
    changeset = Ingredient.changeset(%Ingredient{}, roww)
    Repo.insert!(changeset)
  end
end

#File.stream!("././ingredients.csv")
#|> Stream.drop(1)
#|> CSV.decode(headers: [:ingredient_name])
#|> Enum.each(&CookingApp.Seeds.store_it/1)
