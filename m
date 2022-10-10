Date: Mon, 10 Oct 2022 10:08:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0PS9p3FFY2UXBjN@...1296...>
References: <20221010071229.7935-1-gert@...1296...>
 <d0c91031-3693-ed91-6e6c-2e52dd8f7d11@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1bQGKYkr4VsvN7dN"
Content-Disposition: inline
In-Reply-To: <d0c91031-3693-ed91-6e6c-2e52dd8f7d11@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--1bQGKYkr4VsvN7dN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 10, 2022 at 10:00:37AM +0200, Antonio Quartulli wrote:
> > -        if (username)
> > +        if (username && *username)
>=20
> super uber nitpick (bike shadding level):
>=20
> I think in other places we perform the very same check using the format:=
=20
> username[0] instead of *username.

I can adjust that in a v2, but first I need to hear what Arne thinks
about this - it's all his code, so I want to be sure that this is not
introducing unexpected side effects.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1bQGKYkr4VsvN7dN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjQ9L2AAoJEB2Cnv7KVigSDOkL/RUTcOsV7zLCxowPx9mqvkdk
LAkfwnVmgoVjnQb0TaTbITISYG54Xd4qKUJyxKyzcWDRNyH++TfooW1uBWBq36oe
2ko9l2cz3XETmRtZJkb0yt2mhLPryQAmBuj8XwNcxZufbKuwvQpk2XWaaYRP89+5
HAWoTjiZuVq7Uv5NIGFrSmQ8UB6U6fIaozdMHfXAPZ9jQSMu33elIQTD3NJX3U9y
lK0uEUsrEJWw7+4ohNb1edFSjZBDQKv4R6+cyCLN8x1SysRv+G7c0rF456vbSfUQ
zS1V+1K3536ucZWb/wNZ0BTlcJN1FDbuqX2Qo8LO8XbKhqX8pRWoTEChlBxrEPrr
snCrsEa6MwtG1YOshoEZ6iSD1ABOWGqvKGf4TpJytqkopwqAkFT6fQWkCN3KmrsC
DG/P6RayYela3lbBNJAQ+yC5XkXPG2jxasVG7FXPTks/fsVZq4qg1Bg+VFIC4dm/
DteatXRe0Ja4Wg4tkF9bMQeJEgycg63+APzxG8QHUA==
=rBAG
-----END PGP SIGNATURE-----

--1bQGKYkr4VsvN7dN--

