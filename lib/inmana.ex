defmodule Inmana do
  alias Inmana.Restaurants.Create

  defdelegate create_restaurant(params), to: Create, as: :call
end
