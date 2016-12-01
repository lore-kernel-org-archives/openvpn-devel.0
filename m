Date: Thu, 1 Dec 2016 09:07:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201080741.GE78624@...1296...>
References: <1480466372-2396-1-git-send-email-selva.nair@...277...>
	<201611301858.uAUIwRPD071804@...2054...>
	<bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Force 'def1' method when
 --redirect-gateway is done through service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 30, 2016 at 11:06:02PM +0100, Arne Schwabe wrote:
> Slight correction. We actually set 0.0.0.0/0 on Android but Android
> *always* translates that into a 0.0.0.0/1 and a 128.0.0.0/1 rule.
>=20
> We could do the same and do the translation in the interactive service
> instead of OpenVPN itself.

We could, but that wouldn't solve the issue of OpenVPN trying to=20
remove the existing default route (which we would have to special-case-and-
ignore) and reinstall it later on (which must not be translated to
2x /1, but ignored as well).

The service code doesn't know whether a route is "for the VPN API" or
"for anything else" (which openvpn on "non VPN API" platforms always
could do) so this would be a much more intrusive change...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYP9pNAAoJEB2Cnv7KVigSCEAL/0ymObxxieipaSJ7VPrYXmpt
a41Mv/yIksr1EhftBmy559piVJOUKpx2w/PWNQ+l69w4EEHjFTBCwoWTlIQXk8Ze
TIdqbNpRxxHs//2GkWVQE7InVdZ5U9zNZZCQ5/VaiktRtees5y0wMS4P5tU4n0Vu
Kbwr5dCKQd1oIw1tSxuIXB5eUbtBGMt3hlJI209YvHZaY//65nbzjMnCnyFN2Y9D
2ZIIPpVNO4ej/P/L0I+DYG39nK+IhZAI1AYtBVIixhzeP5ltqHdE9MhfBhbFLVag
BCd7YBRdK6VCNeQ1bVFtG7grcYcMuSO4B62a42zcLbytNBFpnuhVsAsGszzPQJer
x50w7AiZ7GtzBeUcB+Rxj46VHvRJj1ROkFWgqN7LK5nkiJtHkC97ruAUp25hiq+9
CPcpSzS1cjM4EOREI54qj3AS54z8/sFdWXkONY+0nhBMPruU2kW+4AfKXktXoeQg
fbN/jI7zncVrXxRqcvb1zSwjIbxbf/bwcucrw5qHwg==
=4IeE
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

