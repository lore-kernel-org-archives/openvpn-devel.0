References: <20200727183436.6625-1-gert@...1296...>
 <20200727183436.6625-2-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9b17bd09-a11d-20c3-2a02-96f562f3b670@...1227...>
Date: Mon, 27 Jul 2020 23:05:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200727183436.6625-2-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YKa2I1tA1mvKbpvu7QGU9jYHG2qm42kdP"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Abort client-connect handler loop
 after first handler sets 'disable'.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YKa2I1tA1mvKbpvu7QGU9jYHG2qm42kdP
Content-Type: multipart/mixed; boundary="C6EbePNtQ5Fe3YvxHjDRXytHxDrejwb5e"

--C6EbePNtQ5Fe3YvxHjDRXytHxDrejwb5e
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.07.20 um 20:34 schrieb Gert Doering:
> The old code would run all (succeeding) handlers, then discover "one of
> them set the 'disable' flag for this client", and then unroll all the
> handlers.
>=20
> Moving the 'disable' check into the loop makes it stop after the first
> handler that fails or (succeeds and sets 'disable').  This is a bit
> more logical in the log files, and has less potential side effects
> due to running "later" client-connect handlers when we already know
> they will have to be unrolled.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>

This another of the 'review is easy if you ignore white space' patches.
This slightly changes the behaviour but I don't see a problem with the
behaviour change to abort early.

Acked-By: Arne Schwabe <arne@...1227...>



--C6EbePNtQ5Fe3YvxHjDRXytHxDrejwb5e--

--YKa2I1tA1mvKbpvu7QGU9jYHG2qm42kdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8fQYkACgkQFRhsZwKx
RFQ/gRAAi31zTrkw6gP0vQeb52AAwZV2xdAuVonXR9BbCFDNu39wgVzrlq3KpcpD
rFJ5oHYgAnPdQ5XONpfJW5kXGEjyiK38brH89iAr+7oQhkftoUcj3zAukxIEORY5
m2uTzgVcuW89lVBVCDIiU4CiffnAuAognxCJvnyZqnRjgkt9rkUN75MMVwjj4ZZO
3rVN93TFSGT5KYgoUQQv3uA+RUGERyZg1MoD1uApI9KouvWDxneRTqS9l4cE7soq
oyuUGLSSg+bh3rX18sktai9u5WedXv1X2j8dBhuA2fxV1kpjNw+peiY1ZOatNezW
alwskgUt7vZhyEwHMnGALYBdBeZfnSepJICJ9C6fNeN8wUlKDYaeoKryLF3PRgZI
J+zuRkTat7zEhk12ZP9pD0iOnQQGjOEO6bBxUcPw650Ft+wdeQCT/rJ076g0jC3O
AL7twnIqPEsxm4BUpxIW0Qip9cTuSyT9QgB2BwnnsqNvE0J/JZNoJdh+nUqoRIfb
162moYPImEWK6uTkg6o9ypzTszz1rsTsLT7pfMIKEFBPTXXw5NJLqyZM3Q9MOvcI
L8r2AGE0kckyCMtnp+r+CM66cSw9vy4xQbEYqisJrZgQQFhrOGZ9SlV2C4Eg8uTA
+TEa7HaJSqm3A1E+pk2bJonRtjPMNHESriwlXkDFyy3yw6cCRKc=
=mNk5
-----END PGP SIGNATURE-----

--YKa2I1tA1mvKbpvu7QGU9jYHG2qm42kdP--

