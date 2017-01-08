defmodule Keyserv.KeyControllerTest do
  use Keyserv.ConnCase

  alias Keyserv.Key
  @valid_attrs %{desc: "some content", email: "some content", fingerprint: "some content", keyid: "some content", pub: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, key_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing keys"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, key_path(conn, :new)
    assert html_response(conn, 200) =~ "New key"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, key_path(conn, :create), key: @valid_attrs
    assert redirected_to(conn) == key_path(conn, :index)
    assert Repo.get_by(Key, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, key_path(conn, :create), key: @invalid_attrs
    assert html_response(conn, 200) =~ "New key"
  end

  test "shows chosen resource", %{conn: conn} do
    key = Repo.insert! %Key{}
    conn = get conn, key_path(conn, :show, key)
    assert html_response(conn, 200) =~ "Show key"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, key_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    key = Repo.insert! %Key{}
    conn = get conn, key_path(conn, :edit, key)
    assert html_response(conn, 200) =~ "Edit key"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    key = Repo.insert! %Key{}
    conn = put conn, key_path(conn, :update, key), key: @valid_attrs
    assert redirected_to(conn) == key_path(conn, :show, key)
    assert Repo.get_by(Key, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    key = Repo.insert! %Key{}
    conn = put conn, key_path(conn, :update, key), key: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit key"
  end

  test "deletes chosen resource", %{conn: conn} do
    key = Repo.insert! %Key{}
    conn = delete conn, key_path(conn, :delete, key)
    assert redirected_to(conn) == key_path(conn, :index)
    refute Repo.get(Key, key.id)
  end
end
