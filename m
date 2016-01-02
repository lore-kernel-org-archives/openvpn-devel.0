Date: Sat, 2 Jan 2016 19:47:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160102184746.GV24952@...1296...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...> <20151226091900.GU24952@...1296...>
	<567E60A9.6020006@...1856...>
	<CAFHpkQEiJevqD7+jQ0+MdFh2Q0XmbFR3=8vTeAYz6meH1pFGAA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jVjnuaWuSOe5XSq+"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEiJevqD7+jQ0+MdFh2Q0XmbFR3=8vTeAYz6meH1pFGAA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jVjnuaWuSOe5XSq+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 02, 2016 at 09:14:21PM +0300, ???????? ?????????????? wrote:
> also, does it make sence to perform unit testing on build like
>=20
> setup server with user/password auth on localhost, connect to is using
> client, see whether it is ok....

We do, but we don't run test setups without certificates (my auth/pass
users *also* have to have a certificate - helps against lost passwords,
because you also need to steal key+cert)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jVjnuaWuSOe5XSq+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVogbUakuBuNlUUl1AQKZRAQApLTAwpPNjiBY1USFyrcsTKZlSTihL+LG
2mTOvNIZR9xLvkG9aApe3Fk7mXtZ2c6yJQ1fWiqQDcOLUtFpoSaqCPweLKfY2C5G
UU7lEHs+XQUgWEcwm3GsKVfifnagm4fF0G/N6JsQbEKIM0u1UP6W1m/nyytHu0QW
I8Es+aCG9jI=
=G7/3
-----END PGP SIGNATURE-----

--jVjnuaWuSOe5XSq+--

