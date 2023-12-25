defmodule Item do
  defstruct [:color, :quantity]
end

defmodule Set do
  defstruct [:items]
end

defmodule Game do
  defstruct [:id, :sets]
end
