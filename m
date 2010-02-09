From: Maciej Piechotka <uzytkownik2@...277...>
Date: Tue, 09 Feb 2010 23:13:53 +0000
Message-ID: <1265757233.5700.48.camel@...1303...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-dU5ogrZ4Un5J0EFYreUM"
Sender: news <news@...1062...>
Subject: [Openvpn-devel] Tap-Win32 - licence and how to use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-dU5ogrZ4Un5J0EFYreUM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm writing a wrapper around the TUN/TAP (for Haskell) on various
systems. I'd like to port it on Windows however:

1. There is very little documentation I found in google. There are some
example but with little comments. Is there any documentation how such I
initialize TUN and TAP device?

2. AFAIK I can use GPL driver in BSD application. However am I allowed
to base on GPL program how to use this driver? (Un)fortunately most
users of TAP-Win32 is on GPL (and library I want to contribute to is on
BSD).

Regards



--=-dU5ogrZ4Un5J0EFYreUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAktx7DEACgkQNtHxai7FolyvDwCglcqc88I62VIB7xMm6mNeETyp
N+oAnAmWnI5tEPFTcHQ9P0B6MQczSo2Q
=+/B8
-----END PGP SIGNATURE-----

--=-dU5ogrZ4Un5J0EFYreUM--



