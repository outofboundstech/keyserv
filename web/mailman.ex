defmodule Keyserv.Mailman do
  use Keyserv.Web, :controller

  alias Keyserv.Key

  alias ExPosta.Message

  def deliver(conn, _params=%{"fingerprint" => fingerprint, "content" => body}) do
    # Lookup email address by fingerprint
    key = Repo.get_by!(Key, fingerprint: fingerprint)
    msg = Message.new(text: body, to: [key.email], subject: "CryptoForm: new message notification")
    pid=ExPosta.send msg
    IO.inspect Task.await(pid)

    text conn, "Ok"
  end
end
