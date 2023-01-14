x = Nxnp.arrange(-5.0, 5.0, 0.1)
y = Activator.step(x)

alias Expyplot.Plot
Plot.plot([x, y])
Plot.show()

x = Nx.tensor([[1.0, 0.5]])
w1 = Nx.tensor([[0.1, 0.3, 0.5],[0.2,0.4,0.6]])
b1 = Nx.tensor([0.1, 0.2, 0.3])
Nx.shape x
Nx.shape w1
Nx.shape b1
a1 = Nx.dot(x, w1) |> Nx.add(b1)
z1 = Activator.sigmoid(Nx.to_flat_list(a1))

w2 = Nx.tensor([[0.1,0.4],[0.2, 0.5],[0.3, 0.6]])
b2 = Nx.tensor([0.1, 0.2])
a2 = Nx.dot(z1, w2) |> Nx.add(b2)
z2 = Activator.sigmoid(Nx.to_flat_list(a2))
