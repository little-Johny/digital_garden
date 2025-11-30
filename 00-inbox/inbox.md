# Pattern Matching

## equivalence operator

```elixir
x = 1 
```

<!-- livebook:{"output":true} -->

```
1
```

```elixir
1 = x
```

<!-- livebook:{"output":true} -->

```
1
```

```elixir
2 = x
```

<!-- livebook:{"output":true} -->

```
** (MatchError) no match of right hand side value: 1
    (stdlib 6.2.2) erl_eval.erl:667: :erl_eval.expr/6
    #cell:nq6o66zey7y5onp5:1: (file)
```

```elixir
# variable can only be assigned when it is 
# on the left-hand side of the equivalence operator
1 = undefined
```

<!-- livebook:{"output":true} -->

```
error: undefined variable "undefined"
└─ AppData/Local/livebook/autosaved/2025_11_30/04_37_a33u/pattern_matching.livemd#cell:ysasztmtxg2zn6n5:3

```

<!-- livebook:{"output":true} -->

```
** (CompileError) cannot compile cell (errors have been logged)
```

## Descompose data structures by the pattern matching

```elixir
{a, b, c} = { :moneda, "moneda", true}
```

<!-- livebook:{"output":true} -->

```
{:moneda, "moneda", true}
```

```elixir
IO.inspect(a)
IO.inspect(b)
IO.inspect(c)
```

<!-- livebook:{"output":true} -->

```
:moneda
"moneda"
true
```

<!-- livebook:{"output":true} -->

```
true
```

```elixir
{a, b, c} = {"moneda", :moneda}
```

<!-- livebook:{"output":true} -->

```
** (MatchError) no match of right hand side value: {"moneda", :moneda}
    (stdlib 6.2.2) erl_eval.erl:667: :erl_eval.expr/6
    #cell:fapsero54vuiabhx:1: (file)
```

```elixir
{a, b, c} = [3, 3, 12]
```

<!-- livebook:{"output":true} -->

```
** (MatchError) no match of right hand side value: [3, 3, 12]
    (stdlib 6.2.2) erl_eval.erl:667: :erl_eval.expr/6
    #cell:dar3f4o3ehbyspes:1: (file)
```

```elixir
{:ok, result} = {:ok, "success"}
IO.inspect(result)
```

<!-- livebook:{"output":true} -->

```
"success"
```

<!-- livebook:{"output":true} -->

```
"success"
```

```elixir
{:ok, resuls} = {:error, :oops} 
# it throws an exception because the atoms have value from their declaration
IO.puts(:ok)
```

<!-- livebook:{"output":true} -->

```
** (MatchError) no match of right hand side value: {:error, :oops}
    (stdlib 6.2.2) erl_eval.erl:667: :erl_eval.expr/6
    #cell:qm7bzgdklipwggmh:1: (file)
```

```elixir
[a, b, c] = [33, 1, 2]
```

<!-- livebook:{"output":true} -->

```
[33, 1, 2]
```

```elixir
# extract the first element
[head | tail] = [1,2,3]
```

<!-- livebook:{"output":true} -->

```
[1, 2, 3]
```

```elixir
head
```

<!-- livebook:{"output":true} -->

```
1
```

```elixir
tail
```

<!-- livebook:{"output":true} -->

```
[2, 3]
```

```elixir
[first | other] = []
```

<!-- livebook:{"output":true} -->

```
** (MatchError) no match of right hand side value: []
    (stdlib 6.2.2) erl_eval.erl:667: :erl_eval.expr/6
    #cell:jeyadjfqhbcmvq4p:1: (file)
```

```elixir
[first | rest] =[1000, :no, :yes, :book]
IO.inspect(first)
IO.inspect(rest)
IO.inspect(Enum.at(rest, 1))
```

<!-- livebook:{"output":true} -->

```
1000
[:no, :yes, :book]
:yes
```

<!-- livebook:{"output":true} -->

```
:yes
```

```elixir
[first | rest] = [1000, :no, :yes, :book]

# Ahora rompemos 'rest'
# Ignoramos el primero con _ y capturamos el segundo
[_, segundo_elemento | _resto_final] = rest

IO.inspect(segundo_elemento)
# Salida: :yes
```

<!-- livebook:{"output":true} -->

```
:yes
```

<!-- livebook:{"output":true} -->

```
:yes
```

```elixir
list = [1, 2, 3]
# add elements
[0 | list]
```

<!-- livebook:{"output":true} -->

```
[0, 1, 2, 3]
```

## Pin operator

```elixir
x = 1
```

<!-- livebook:{"output":true} -->

```
1
```

```elixir
^x =2
```

<!-- livebook:{"output":true} -->

```
** (MatchError) no match of right hand side value: 2
    (stdlib 6.2.2) erl_eval.erl:667: :erl_eval.expr/6
    #cell:jtvxllod46x42qtd:1: (file)
```

```elixir
[^x, 2, 3] = [1, 2, 3]
```

<!-- livebook:{"output":true} -->

```
[1, 2, 3]
```

```elixir
{y,^x } = {2, 1}
```

<!-- livebook:{"output":true} -->

```
{2, 1}
```

```elixir
[head | _] =[1, 2, 3]
```

<!-- livebook:{"output":true} -->

```
[1, 2, 3]
```

```elixir
head
```

<!-- livebook:{"output":true} -->

```
1
```


---

# extructuras de control ->  case and cond

# control structures

## case

```elixir
case {1, 2, 3} do 
  {4, 5, 6} ->
    "this clause won't match"
  {1, x, 3} ->
    "succesfully clause, bind x to 2"
  _ -> 
    "this is a default"
end
```

<!-- livebook:{"output":true} -->

```
warning: variable "x" is unused (if the variable is not meant to be used, prefix it with an underscore)
└─ AppData/Local/livebook/autosaved/2025_11_30/05_34_n752/control_structures.livemd#cell:jewvawedz7n24awt:4

```

<!-- livebook:{"output":true} -->

```
"succesfully clause, bind x to 2"
```

```elixir
x = 1

case 10 do
  ^x ->
    "wont' match"
  _ ->
    "will match"
      
end
```

<!-- livebook:{"output":true} -->

```
"will match"
```

```elixir
case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "will match"
  _ ->
    "would match, if guard condition were not satisfied"
end
```

<!-- livebook:{"output":true} -->

```
"will match"
```

```elixir
case 1 do
  x when hd(x) -> "won't match"
  x -> "got #{x}"
end
```

<!-- livebook:{"output":true} -->

```
"got 1"
```

## Cond

```elixir
cond do
  2 + 2 == 5 ->
    "this will not be true"
  2 * 2 == 3 ->
    "this wil not be true"
  1 + 1 == 2 ->
    "this will be true"
end
```

<!-- livebook:{"output":true} -->

```
"this will be true"
```

```elixir
cond do
  2 + 2 == 5 ->
    "this will not be true"
  2 * 2 == 3 ->
    "this wil not be true"
  true ->
    "this will be true"
end
```

<!-- livebook:{"output":true} -->

```
"this will be true"
```

```elixir
cond do
  hd([1,2,3]) ->
    "1 is considered as true"
  false ->
    "this is false"
end
```

<!-- livebook:{"output":true} -->

```
** (CondClauseError) no cond clause evaluated to a truthy value
    #cell:glfwp7gglu2qzoer:4: (file)
```

# if & unless

# If & unless

## If

```elixir
if true do
  "working..."
end
```

<!-- livebook:{"output":true} -->

```
"working..."
```

```elixir
unless true do
  "this will never be seen"
end
```

<!-- livebook:{"output":true} -->

```
nil
```

```elixir
unless false do
  "not working..."
end
```

<!-- livebook:{"output":true} -->

```
"not working..."
```

```elixir
# using else
if nil do
  "this not working never"
else
  "working..."
end
```

<!-- livebook:{"output":true} -->

```
"working..."
```

```elixir
unless true do
  "doen't work..."
else
  "working..."
end
```

<!-- livebook:{"output":true} -->

```
"working..."
```

```elixir
x = 1

if true do
  x = x + 1
end

IO.puts(x)
```

<!-- livebook:{"output":true} -->

```
warning: variable "x" is unused (there is a variable with the same name in the context, use the pin operator (^) to match on it or prefix this variable with underscore if it is not meant to be used)
└─ AppData/Local/livebook/autosaved/2025_11_30/06_05_353z/if_unless.livemd#cell:2ylxq3om54erbw6z:4

1
```

<!-- livebook:{"output":true} -->

```
:ok
```

```elixir
x = if true do
  x + 1
end

IO.puts(x)
```

<!-- livebook:{"output":true} -->

```
2
```

<!-- livebook:{"output":true} -->

```
:ok
```
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
