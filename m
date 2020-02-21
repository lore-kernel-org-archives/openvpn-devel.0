References: <E1j0kkZ-00080K-9z@...2508...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ca6440c5-a542-e52a-57fe-bb80cc88d818@...1227...>
Date: Fri, 21 Feb 2020 14:01:06 +0100
MIME-Version: 1.0
In-Reply-To: <E1j0kkZ-00080K-9z@...2508...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LrCretg46dWLGmzcWq4cfvs2CUsBdN4If"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrCretg46dWLGmzcWq4cfvs2CUsBdN4If
Content-Type: multipart/mixed; boundary="WQLWLEEaiQG9XTTAVOEZwlWKTA9gHyaKH"

--WQLWLEEaiQG9XTTAVOEZwlWKTA9gHyaKH
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.02.20 um 12:08 schrieb Juliusz Sosinowicz:
> Hi Antonio,
>=20
> Gert is correct, our compatibility layer is a set of functions in
> wolfSSL which emulate the OpenSSL API. These functions are then macro
> defined to have the same names as the OpenSSL functions. The configure
> script needs to know where the wolfSSL headers are and that it should
> link against the wolfSSL binary, not OpenSSL. This is the reason for the
> configure script changes.

But OpenSSL also its opensslconf.h header and does not force you to
important into each file it uses. I find that argument very weak. If it
is something that is essential for your compat layer then you should
probably include it in the top of each compatibility header.

Arne


--WQLWLEEaiQG9XTTAVOEZwlWKTA9gHyaKH--

--LrCretg46dWLGmzcWq4cfvs2CUsBdN4If
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5P1JIACgkQFRhsZwKx
RFToVA/+MIQBhV/iDPZaL2Bdowr5w3qkAucO3SOJpNva5MyzwoNOSephZR8iG2sa
nVlBF+aZeT74UfGD59xCTJU0uWDeSCr+N1wHjoxTGCss8DTBbWGqHPgFrCLetiKz
PCb/cgTpzQwO75xWDdZNCPPRhMDC/gluEltLa1wJN6E+KzvlriUls0Dun9860Bvo
4LemomXxSfS+vV8xs0PfJpsVoGvxpDJ7VoLKW1M3gl3mStYOrQ5T/B416DZttktP
RR6BtgfXF19WZEnB1QeTtkaeSZOxByZi85aTpE8FQNdfkwYvC9fcvkHWAFAVJycT
76NfmTTdMEc0LTzrTlVnXodKua7CfD5cAq4jFBytAg4nrcKXwF2zrk+Qh2cy3Cbf
PygnGQsou9LQbsUSvdfxtCQ5ZpKn6zfjGndyfj0bgZjPuIaYy+mV0M3h7dk/WOfR
ayNR9TpMURaQcBV1HsaDDA2RB0SZf0H3jFHU9HbG186L8ucjyZwXZg1kUrc+Mk/L
M/ycaub0QyZDSg7C0kGfunSMH2Lo4O8KvCFPG0+D23twhxjxtkZgkgvLdoAvKKSU
uk+1OdlkBcV5L7m9rr7k+rYCS+vq/xzJJTx0nyV4zTt//Z8CzPKlUduP3YnCwGiq
3Z6h/M0IfJjvoyqUQHU3hEGXmk90vxbBicIAM8ZRK6Ubo75UYZQ=
=dZxv
-----END PGP SIGNATURE-----

--LrCretg46dWLGmzcWq4cfvs2CUsBdN4If--

