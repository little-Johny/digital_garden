defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    do_palette_bit_size(color_count, 1)
  end

  defp do_palette_bit_size(color_count, acc) do
    if 2 ** acc >= color_count do
      acc
    else
      do_palette_bit_size(color_count, acc + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    index_size = palette_bit_size(color_count)
    <<pixel_color_index::size(index_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    first_size = palette_bit_size(color_count)

    case picture do
      <<>> -> nil
      <<first::size(first_size), _rest::bitstring>> -> first
    end
  end

  def drop_first_pixel(picture, color_count) do
    var_size = palette_bit_size(color_count)
    case picture do
      <<>> -> <<>>
      <<_first::size(var_size), rest::bitstring>> -> rest
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
