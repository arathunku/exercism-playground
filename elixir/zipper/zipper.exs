defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  @type trail :: [ { :left, any, BinTree.t } | { :right, any, BinTree.t } ]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(tree) do
    {tree, []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree({tree, []}), do: tree
  def to_tree(z) do
    to_tree(up(z))
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value({ nil, _}), do: nil
  def value({ %{value: value}, _}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left({%{left: nil}, _}), do: nil
  def left({%{value: value, left: l, right: r}, t}) do
    {l, [ {:right, value, r} | t]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def left({%{right: nil}, _}), do: nil
  def right({%{value: value, left: l, right: r}, t}) do
    {r, [ {:left, value, l} | t]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up({_, []}), do: nil
  def up({tree, [{:right, value, r} | t]}) do
    {%BinTree{value: value, left: tree, right: r}, t}
  end

  def up({tree, [{:left, value, l} | t]}) do
    {%BinTree{value: value, left: l, right: tree}, t}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value({tree, t}, v) do
    {Map.merge(tree, %{value: v}), t}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left({tree, t}, l) do
    {Map.merge(tree, %{left: l}), t}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right({tree, t}, r) do
    {Map.merge(tree, %{right: r}), t}
  end
end
