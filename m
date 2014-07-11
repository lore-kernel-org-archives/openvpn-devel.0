Date: Fri, 11 Jul 2014 20:07:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140711180758.GJ1118@...1296...>
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<53BFA759.7060307@...1227...> <53BFA9A0.3020605@...1147...>
	<53BFACDE.9050609@...1227...> <53BFAF81.2080705@...1147...>
	<53BFC22C.5010601@...1227...> <53BFF9BE.1090204@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SXJj2kVWw/JBQDhF"
Content-Disposition: inline
In-Reply-To: <53BFF9BE.1090204@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
	configuration file
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

--SXJj2kVWw/JBQDhF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 11, 2014 at 04:50:38PM +0200, Jan Just Keijser wrote:
> the master branch (from openvpn-testing) currently does not build on=20
> either CentOS 5 and 6.

Install snappy(-dev) or run configure with --disable-snappy :-) - besides=20
that, it should build just fine.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SXJj2kVWw/JBQDhF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU8An/qkuBuNlUUl1AQKf8gP+J6i8l6/i+cF6Yt/JcvqHZb4kmcl18mrJ
9hDglebiUYkQm8z34f1Lc0vaZRCr6V03kRRHtaMe13X4+M9ctLLZKDnxeMH1AKNt
NQU29UnCcgt0OmJYamgKQC3zVwYJKYDJcak4qCVIGRJEzFxbYweG63i0WcXeX5Az
1HkTkf6QLJ0=
=R10g
-----END PGP SIGNATURE-----

--SXJj2kVWw/JBQDhF--

