Date: Thu, 21 Apr 2016 22:36:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160421203643.GM53051@...1296...>
References: <1461270286-3549-1-git-send-email-janjust@...1147...>
	<571937C6.5000102@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NV8Q+b3U03j8aVmL"
Content-Disposition: inline
In-Reply-To: <571937C6.5000102@...1147...>
Subject: Re: [Openvpn-devel] Add support for pushable encryption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--NV8Q+b3U03j8aVmL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2016 at 10:27:50PM +0200, Jan Just Keijser wrote:
> there are a few notes about this patch:
>=20
> - I've tested it on Linux only
> - it works when pushing both --cipher andi/or --auth
> - works by re-doing part of the encryption setup (you'll see some=20
> messages fly by twice )
> - pushing an HMAC (e.g. push "auth SHA256"") does **not** work in=20
> combination with --tls-auth: when tls-auth is used all incoming packets=20
> are signed using the "original" HMAC cipher and you won't even get to=20
> the "push" stage to get the correct cipher.

Does it work on the server side, that is, having a ccd/ file or script
that tells the server "cipher <foo>" for a given client?

Otherwise: impressive :-) (I leave the actual code review to Steffan)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NV8Q+b3U03j8aVmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVxk52qkuBuNlUUl1AQIM7gQAhKV/G8g37j1cWE+LWjY64JFW07cHl2RD
bO3phKgUhZejG+iK/ntlrOm3q7ELz9CYLIrV45aUzF95ZssFqVnZaDEbrK6eNKBG
uEtpbGFGp+f7JuJipHDy624JQfwVxUnnG3HLHS0lGwR0SUUNz0HgzTMfR10oDDnM
TNJM67Eh+LU=
=4AsA
-----END PGP SIGNATURE-----

--NV8Q+b3U03j8aVmL--

