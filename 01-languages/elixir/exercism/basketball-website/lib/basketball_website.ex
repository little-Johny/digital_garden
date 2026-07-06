defmodule BasketballWebsite do
  # split path in parts to extract the first element(will be current key)
  # then pass to recursive function with the remaining path(that will be our new path)
  def extract_from_path(data, path) do
    [key | path_tail] = String.split(path,".")
    do_extract_from_path(key, path_tail, data)
  end

  # if the path is empty, we return the current key value
  # if the path isn't empty, pass to recursive function with the next key, the rest of the path to get the value of the rest of the nested structure and the current key value
  defp do_extract_from_path(key, [], data), do: data[key]
  defp do_extract_from_path(key, [next_key | next_path_tail], data) do
    do_extract_from_path(next_key, next_path_tail, data[key])
  end

  # we used get_in function from Kernel module that receives a nested structure and a path(which is a list of keys) it returns the value of the last key.
  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
