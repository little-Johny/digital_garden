
# Keyword Lists & Maps

# Associative data structures

## Keyword lists

```elixir
simple = String.split("1 2 3", " ")
withoutoptions = String.split("1 2  3 ", " ")
withoptions = String.split("1  2   3", " ", [trim: true])
withotheroptions = String.split("1  2   3", " ", [dots: true])

IO.inspect(simple, label: "siple example")
IO.inspect(withoutoptions, label: "without options example")
IO.inspect(withoptions, label: "with options example")
IO.inspect(withotheroptions, label: "whit other options example")
```

<!-- livebook:{"output":true} -->

```
siple example: ["1", "2", "3"]
without options example: ["1", "2", "", "3", ""]
with options example: ["1", "2", "3"]
whit other options example: ["1", "", "2", "", "", "3"]
```

<!-- livebook:{"output":true} -->

```
["1", "", "2", "", "", "3"]
```

```elixir
# Syntactic sugar
[{:trim, true}] == [trim: true]
```

<!-- livebook:{"output":true} -->

```
true
```

```elixir
list = [a: 1, b: 2]
newlist = list ++ [c: 3]
list == newlist

```

<!-- livebook:{"output":true} -->

```
false
```

```elixir
othernewlist = [a: 0] ++ list
list == othernewlist
```

<!-- livebook:{"output":true} -->

```
false
```

```elixir
# access to elements
list[:a]
othernewlist[:a] # if key repeat only gets the first value
```

<!-- livebook:{"output":true} -->

```
0
```

<!-- livebook:{"force_markdown":true} -->

```elixir
query = 
  from w in Weather,
    where: w.prcp > 0,
    where: w.temp < 20,
    select: w
```

```elixir

```

<!-- livebook:{"output":true} -->

```
nil
```

## Maps

```elixir
map = %{:a => 1, :b => 2}
map[:a]
```

<!-- livebook:{"output":true} -->

```
1
```

```elixir
%{} = %{:a => 1, :b => 2}
```

<!-- livebook:{"output":true} -->

```
%{b: 2, a: 1}
```

```elixir
%{:a => a} = %{:a => 1, :b => 2}
```

<!-- livebook:{"output":true} -->

```
%{b: 2, a: 1}
```

```elixir
a
```

<!-- livebook:{"output":true} -->

```
1
```

```elixir
n = 1
map = %{n => :one}
map[n]
```

<!-- livebook:{"output":true} -->

```
:one
```

```elixir
%{^n => :one} = %{1 => :one, 2 => :two}
```

<!-- livebook:{"output":true} -->

```
%{1 => :one, 2 => :two}
```

```elixir
mapita = %{ :name =>  "johny", "lastname" => "molano"}
Map.get(mapita, :name)
Map.get(mapita, "lastname")
newmap = Map.put(mapita, 19, :age)
%{newmap | 19 => "age"}
simplymap = %{city: "bogota", country: "colombia"}
simplymap.city

```

<!-- livebook:{"output":true} -->

```
"bogota"
```

```elixir
#syntactic sugar when all keys on a map are atoms
%{a: 1, b: 2} == %{:a => 1,:b => 2 }

```

<!-- livebook:{"output":true} -->

```
true
```
