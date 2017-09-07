Date: Thu, 7 Sep 2017 08:13:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170907061333.GC70062@...1296...>
References: <20170907022827.10658-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m62MDEjg5u5lTXSK"
Content-Disposition: inline
In-Reply-To: <20170907022827.10658-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--m62MDEjg5u5lTXSK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Thu, Sep 07, 2017 at 04:28:27AM +0200, David Sommerseth wrote:
> We are using a deprecated function, LZ4_compress_limitedOutput(), which
> will be removed with time.  The correct function to use is LZ4_compress_d=
efault().
> Both function takes the same number of arguments and data types, so the c=
hange
> is minimal.

I wonder why we should bother to have a wrapper function here.

We can ship a lz4 library that has the new function, and if a system only
provides an older version, declare it unsuitable (configure check) and
use the bundled one.

Less #ifdef

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--m62MDEjg5u5lTXSK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZsOONAAoJEB2Cnv7KVigSzbIL/1O9QOit8LZ6ViC/QU0A/awb
Ki1TMRLD2BtVG1sd5cjGJiDLXz3Hvtkatt1R+C8WgFgH5oB9UbuEEX8XS7isqeTd
vhUgOLQhgAaZCCGknlizc0i+bFu4a4z6k/whtnasUCts96shDvNWH8s+mWCk6t/4
Nk//DcedKHPhIVFLOHSq+qYSx0LKjljXtENpBKGwq3EzRHxrcbVLFQYASoi4PlP+
xgJQfgPn9llrs8yj3iqae4//dszCGG7yKmzGOGUhwxIoWV9wLWBMXmgWiv1S2sJw
UNmxnp9G5WtHY+EiktmINx0HzirNBlx3w/6MdPfVRobsS4b2MbsyTApCwXSA6Qp3
xm185A2STRM3ICO5e6AZ8tXH0RPWU14BqO8k9xz23ZcEzyp9e0K00LefGcSxKiEY
8d2yl8N2b545XxunvL0WZUjtK39hAR6bKUEbkI0KT8rg5cfz/iG1wwQ52B2KzNVu
99CdramAGxVT1Vo13ALeLlcsEF/r1R3f3mcHz4q7Fw==
=69NA
-----END PGP SIGNATURE-----

--m62MDEjg5u5lTXSK--

