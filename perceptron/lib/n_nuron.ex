defmodule NNuron do
  def get_data() do
    {train_images, train_labels} = Scidata.MNIST.download()
    {test_images, test_labels} = Scidata.MNIST.download_test()
    [{train_images, train_labels},{test_images, test_labels}]
  end

  def init_network(images) do
    {images_binary, images_type, images_shape} = images
    images_binary
    |> Nx.from_binary(images_type)
    |> Nx.reshape(images_shape)
    |> Nx.divide(255)
  end



end
