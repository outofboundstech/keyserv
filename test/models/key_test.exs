defmodule Keyserv.KeyTest do
  use Keyserv.ModelCase

  alias Keyserv.Key

  @valid_attrs %{desc: "some content", email: "some content", fingerprint: "some content", keyid: "some content", pub: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Key.changeset(%Key{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Key.changeset(%Key{}, @invalid_attrs)
    refute changeset.valid?
  end
end
