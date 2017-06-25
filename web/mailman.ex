defmodule Keyserv.Mailman do
  use Keyserv.Web, :controller

  alias :gen_smtp_client, as: SMTP
  alias :mimemail, as: MIME

  alias Keyserv.Key

  def deliver(conn, _params=%{"fingerprint" => fingerprint, "content" => content}) do
    # Lookup email address by fingerprint
    key = Repo.get_by!(Key, fingerprint: fingerprint)

    mimeheaders = [ {"From", "cryptoform@marceloomens.com"}, {"Subject", "CryptoForm: new message notification"}, {"To", Key.as_phrase key}]
    payload = rfc3156_mimemail(mimeheaders, content)
    SMTP.send({"cryptoform@marceloomens.com", [key.email], payload}, Application.get_env(:keyserv, Keyserv.Mailman))

    text conn, "Ok"
  end

  defp rfc3156_mimemail(headers, content) do
    # desc = "This is an OpenPGP/MIME encrypted message (RFC 4880 and 3156)"
    id = { "application", "pgp-encrypted", [{"Content-Description", "PGP/MIME version identification"}], [], "Version: 1" }
    msg = { "application", "octet-stream", [{"Content-Description", "OpenPGP encrypted message"}], [{"content-type-params", [{"name", "encrypted.asc"}]}, {"disposition", "inline"}, {"disposition-params", [{"filename", "encrypted.asc"}]}], content }
    MIME.encode({ "multipart", "encrypted", headers, [ {"content-type-params", [{"protocol", "application/pgp-encrypted"}]} ], [id, msg] })
  end
end
