Date: Thu, 23 Jun 2016 20:19:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623181916.GM79504@...1296...>
References: <1465411084-16279-1-git-send-email-steffan@...1856...>
	<1465852632-7278-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XiX5sJQOWZsNRXst"
Content-Disposition: inline
In-Reply-To: <1465852632-7278-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCHv3 4/5] Add options to restrict cipher
 negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--XiX5sJQOWZsNRXst
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 13, 2016 at 11:17:12PM +0200, Steffan Karger wrote:
> Add --ncp-disable to completely disable cipher negotiation, and
> --ncp-ciphers to specify which ciphers to accept from the server.
>=20
> v2:
>  * fix --disable-crypto builds
>  * use register_signal() instead of operating directly on c->sig
>  * add man-page entry for new options
>=20
> v3:
>  * rebased on client-side NCP v3

Looks generally OK, too.=20=20

The OPT_P_NCP bit introduced here is used in 3/5, so the distribution
of new bits and pieces on the 3 parts is not ideal (because applying 3/5
alone would make it not compile) - but you already know that :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XiX5sJQOWZsNRXst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2woJKkuBuNlUUl1AQLLAAP+M5HUTc+pqQ12ZJvP9asf0ZvbGAAhBH7g
ZpEIywBZ6YePcMz/JQ6X1MvAxvL1PPv1GrTPJUyoVIQd9FPl84IeTV0wP/CtVl/O
uZ7OevJZ0tT0Kjk5sCT/9R1HQkFXKO9t69LYXWENkuTb+/SGD+JA6TXiBYINN7Cl
1fR1BXgF56g=
=Cr2v
-----END PGP SIGNATURE-----

--XiX5sJQOWZsNRXst--

