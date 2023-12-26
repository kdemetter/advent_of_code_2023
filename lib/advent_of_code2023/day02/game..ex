defmodule Day02.Item do
  defstruct [:color, :quantity]

  def to_string(item) do
    "#{item.quantity} #{item.color}"
  end

end

defmodule Day02.Set do
  defstruct [:items]
end

defmodule Day02.Game do
  defstruct [:id, :sets]
end
