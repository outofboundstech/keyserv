defmodule Keyserv.Mailman do
  use Keyserv.Web, :controller

  alias :gen_smtp_client, as: SMTP
  alias :mimemail, as: MIME

  alias Keyserv.Key

  def deliver(conn, _params=%{"fingerprint" => fingerprint, "content" => content}) do
    # Lookup email address by fingerprint
    key = Repo.get_by!(Key, fingerprint: fingerprint)
    body = ~s(Subject: CryptoForm: new message notification\r\nTo: #{key.email}\r\n\r\n#{content})
    SMTP.send({"cryptoform@marceloomens.com", [key.email], body}, Application.get_env(:keyserv, Keyserv.Mailman))

    text conn, "Ok"
  end
end
