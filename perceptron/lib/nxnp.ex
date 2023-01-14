defmodule Nxnp do

  def arrange(start, stop, pitch) do
    string_float = Float.to_string(stop)
    <<head,46,tail::binary>> = string_float
    s = <<head>> |> String.to_integer

    num = String.codepoints(tail) |> length()
    point_list  = Enum.map(1..num, fn _ -> pitch end)
    digit = Enum.reduce(point_list, fn x, acc -> x * acc end)

    e = String.to_integer(tail)
    finish = (s * 10) + e
    {begin, _} = start / pitch |> Float.to_string() |> Integer.parse()

    Enum.map(begin..finish, fn x -> Float.round(x * digit, num) end)
  end

end
