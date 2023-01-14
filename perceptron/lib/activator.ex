defmodule Activator do
  import Mogrify
  def step(x_list) when is_list(x_list) do
    broadcast(x_list)
    |> Nx.to_flat_list
    |> Enum.map(&step(&1))
  end

  def step(x) do
    case x do
      x when x <= 0 -> 0
      x when x > 0 -> 1
    end
  end
  def sigmoid(x) when is_number(x) do
    ans = x
    |> Nx.multiply(-1)
    |> Nx.exp()

    Nx.divide(1, Nx.add(1,ans))
  end

  def sigmoid(x) when is_list(x) do
      ans = broadcast(x)
      |> Nx.multiply(-1)
      |> Nx.exp()

      Nx.divide(1, Nx.add(1, ans))
  end

  def relu(x) when is_number(x) do
    Nx.max(0, x)
    |> Nx.to_number()
  end

  def relu(x) when is_list(x) do
    ans = broadcast(x)
    |> Nx.to_flat_list()
    |> Enum.map(&relu(&1))
  end

  defp broadcast(array) do
    Nx.tensor(array)
    |> Nx.broadcast({array |> length})
  end

  def init_network() do
    w1 = Nx.tensor([[0.1, 0.3, 0.5], [0.2, 0.4, 0.6]])
    b1 = Nx.tensor([0.1, 0.2, 0.3])
    w2 = Nx.tensor([[0.1, 0.4], [0.2, 0.5], [0.3, 0.6]])
    b2 = Nx.tensor([0.1, 0.2])
    w3 = Nx.tensor([[0.1, 0.3], [0.2, 0.4]])
    b3 = Nx.tensor([0.1, 0.2])
    [w1, b1, w2, b2, w3, b3]
  end

  def forward(network, x) do
    [w1, b1, w2, b2, w3, b3] = network

    a1 = Nx.dot(x, w1) |> Nx.add(b1)
    z1 = sigmoid(Nx.to_flat_list(a1))

    a2 = Nx.dot(z1, w2) |> Nx.add(b2)
    z2 = sigmoid(Nx.to_flat_list(a2))

    a3 = Nx.dot(z2, w3) |> Nx.add(b3)

    identity_function(Nx.to_flat_list(a3))
  end


  defp identity_function(x) do
    x
  end

  def softmax_old(a) do
    exp_a = Nx.tensor(a) |> Nx.exp()
    sum_exp_a = Nx.sum(exp_a)
    Nx.divide(exp_a, sum_exp_a)
  end

  def softmax(a) do
    tensor_a = Nx.tensor(a)
    c = tensor_a |> Nx.flatten |> Nx.to_flat_list() |> Enum.max
    a_c = Nx.subtract(tensor_a, c)
    exp_a = Nx.exp(a_c)
    Nx.divide(exp_a, Nx.sum(exp_a))
  end

end
