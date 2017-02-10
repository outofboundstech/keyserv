defmodule Keyserv.Mailman do
  use Keyserv.Web, :controller

  alias Keyserv.Key

  alias ExPosta.Message

  def deliver(conn, _params=%{"fingerprint" => fingerprint, "from" => from, "subject" => subject, "text" => text}) do
    # Lookup email address by fingerprint
    key = Repo.get_by!(Key, fingerprint: fingerprint)
    # Send my email (to, subject, text)
    msg = Message.new(text: text, reply_to: from, to: [key.email], subject: subject)
    pid=ExPosta.send msg
    IO.inspect Task.await(pid)

    text conn, "Ok"
  end
end
