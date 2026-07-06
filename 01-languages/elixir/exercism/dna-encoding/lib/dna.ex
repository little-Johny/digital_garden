defmodule DNA do
  def encode_nucleotide(code_point)
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000
  def encode_nucleotide(?\s), do: 0b0000

  def decode_nucleotide(encoded_code)
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T
  def decode_nucleotide(0b0000), do: ?\s

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode(dna, acc)
  defp do_encode([], acc), do: acc

  defp do_encode([head | tail], acc) do
    new = encode_nucleotide(head)
    acc = <<acc::bitstring, new::4>>
    do_encode(tail, acc)
  end

  def decode(dna) do
    do_decode(dna,[])
  end

  defp do_decode(dna, acc)
  defp do_decode(<<>>, acc), do: acc
  defp do_decode(<<head::4, tail::bitstring>>, acc) do
    new = decode_nucleotide(head)
    acc = acc ++ [new]
    do_decode(tail, acc)
  end
end
