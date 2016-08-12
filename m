Date: Fri, 12 Aug 2016 21:13:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160812191348.GH78279@...1296...>
References: <1471028087-4781-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s8GAKpHVZTOrGbze"
Content-Disposition: inline
In-Reply-To: <1471028087-4781-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix warning appearing in newer
 autoconf/libtool version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--s8GAKpHVZTOrGbze
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2016 at 08:54:47PM +0200, David Sommerseth wrote:
> The warning which appears with autoconf-2.69 with libtool-2.4.2 is:
>=20
>    libtoolize: Remember to add 'LT_INIT' to configure.ac.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index 4f14ebd..69fdd99 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -58,6 +58,7 @@ m4_define([serial_tests], [
>  AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this param=
eter.
>  AC_CANONICAL_HOST
>  AC_USE_SYSTEM_EXTENSIONS
> +LT_INIT

What does that *do*?  I'm a bit wary of adding stuff to autoconf that=20
just appears because a computer says so, especially if it smells like
"more libtool", as we want *less* libtool for all but src/plugins/...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--s8GAKpHVZTOrGbze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV64f66kuBuNlUUl1AQIeGgP/ZbOpANTntroSTDx63XZsxRxWqrXjgYAS
awUjz02z7NKvf03KfD83TEe6MwD/4Hks769IJ07A2nYwbB+TsAdX9Bq+NN6yXhiC
JKwlayMvx3FNklUtQ1KqpSCI5kujLjJo90Zb5DpLMMvcilwLuj8isqoXzT6H7UdM
aphhJlPrXNE=
=SfqV
-----END PGP SIGNATURE-----

--s8GAKpHVZTOrGbze--

