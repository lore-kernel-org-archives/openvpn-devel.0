Date: Thu, 17 Apr 2014 09:08:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140417070812.GN16637@...1296...>
References: <534F142C.1010707@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GA5jH4yfUe2bmJec"
Content-Disposition: inline
In-Reply-To: <534F142C.1010707@...515...>
Subject: Re: [Openvpn-devel] possible socks authentication issue?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--GA5jH4yfUe2bmJec
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 16, 2014 at 05:37:16PM -0600, James Yonan wrote:
> Someone on the Tor lists is claiming that OpenVPN isn't implementing=20
> SOCKSv5 authentication correctly:
>=20
> https://lists.torproject.org/pipermail/tor-dev/2014-March/006427.html
>=20
> Any ideas?

commit 2903eba5dfe35c981329a833845e24de3882161a
Author: Yawning Angel <yawning@...1897...>
Date:   Mon Mar 10 03:47:58 2014 +0000

    Fix SOCKSv5 method selection
...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/8488

:-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GA5jH4yfUe2bmJec
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0993KkuBuNlUUl1AQI2JgP/dVref2ZyfKNd71Md2fxLNPp9B1pwPrM5
tGQBBBUbC8uTxctIbjRIqOerRuNQi6QXAgxtn3mb2+FP+0VIDqPqWnje9hi/4IgZ
YXZG5S3ebvSdSLjO3X+YhSMMhYdJGt7rcWnBJ/+5vm4Bp+i8g5rAdZt28zEhxeh3
K9EPgjxzH6Y=
=3ZpT
-----END PGP SIGNATURE-----

--GA5jH4yfUe2bmJec--

