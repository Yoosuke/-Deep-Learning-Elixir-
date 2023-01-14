defmodule Perceptron do
  @moduledoc """
  Documentation for `Perceptron`.
  """

  @doc """

  ## Examples

      iex> Perceptron.hello()
      :world

  """
  def _and(x1, x2) do
    [w1, w2, theta] = [0.5, 0.5, 0.7]
    tmp = x1 * w1 + x2 * w2
    case tmp do
      tmp when tmp > theta -> 1
      tmp when tmp <= theta -> 0
    end
  end

  def nx_and(x1, x2) do
    x = Nx.tensor([x1, x2])
    w = Nx.tensor([0.5, 0.5])
    b = -0.7
    [tmp] =  Nx.multiply(x, w)
    |> Nx.sum
    |> Nx.add(b)
    |> Nx.to_flat_list()
    case tmp do
      tmp when tmp <= 0  -> 0
      tmp when tmp > 0 -> 1
    end
  end

  def _nand(x1, x2) do
    [w1, w2, theta] = [0.5, 0.5, 0.7] |> Enum.map(& &1 * -1)
    tmp = x1 * w1 + x2 * w2
    case tmp do
      tmp when tmp > theta -> 1
      tmp when tmp <= theta  -> 0
    end
  end

  def nx_nand(x1, x2) do
    x = Nx.tensor([x1, x2])
    w = Nx.tensor([-0.5, -0.5])
    b = 0.7
    [tmp] =  Nx.multiply(x, w)
    |> Nx.sum
    |> Nx.add(b)
    |> Nx.to_flat_list()
    case tmp do
      tmp when tmp <= 0  -> 0
      tmp when tmp > 0 -> 1
    end
  end


  def _or(x1, x2) do
    [w1, w2, theta] = [0.5, 0.5, 0.0]
    tmp = x1 * w1 + x2 * w2
    case tmp do
      tmp when tmp > theta -> 1
      tmp when tmp <= theta  -> 0
    end
  end

  def nx_or(x1, x2) do
    x = Nx.tensor([x1, x2])
    w = Nx.tensor([0.5, 0.5])
    b = 0
    [tmp] =  Nx.multiply(x, w)
    |> Nx.sum
    |> Nx.add(b)
    |> Nx.to_flat_list()
    case tmp do
      tmp when tmp <= 0  -> 0
      tmp when tmp > 0 -> 1
    end
  end

  def nx_xor(x1, x2) do
    s1 = nx_nand(x1, x2)
    s2 = nx_or(x1, x2)
    nx_and(s1,s2)
  end

end
