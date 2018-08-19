Date: Sun, 19 Aug 2018 22:16:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180819201624.GA997@...1296...>
References: <20180819200703.20362-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20180819200703.20362-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix combination of --dev tap and
 --topology subnet across multiple platforms.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 19, 2018 at 10:07:03PM +0200, Gert Doering wrote:
> --topology should have no effect in tap mode (tap is always "subnet"),
> but due to the way options are checked, setting "topology subnet" caught
> an improper branch on all non-linux and non-win32 platforms.
>=20
> Easily tested by adding "--topology subnet" to a "--dev tap" t_client
> test.
>=20
> Tested, verified, and fixed on FreeBSD 10.4, NetBSD 7.0.1, OpenBSD 6.0,
> and OpenSolaris 10.  Compile-tested on MacOS X.
>=20
> Trac: #1085

Oh, because the comments omits that notice (it is in the ticket) - this
is 2.4 only.  Master looks sufficiently different that this won't apply,
and Antonio and I have already conspired and decided that this needs to
be fixed for good in master - like:

 - introduce a new enum "interface_style" or so, which can be
    "TUN_MODE_P2P", "TUN_MODE_SUBNET" and "TAP_MODE" (or so)

 - drop "tun", which tries to do the above in boolean form and fails

 - in all platform code, have a switch/case statement instead of a
   chained or nested if/else, making more explicit what the variants
   are - or, if multiple if/else, at least have unambiguous conditions

(Before you ask: "net30" is not handled as subnet internally - except
on windows - but as point-to-point tun)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbedAYAAoJEB2Cnv7KVigSvMAMALBUjnfo673NG2bXCxK4V0/g
LSptOeGE4/IyF0MH87sbIgoDWxtKBjb3YRgCLZa/chUGF6hT1H+GJu4ZTAFEGZnC
O9nnRvkaiSuEOGrjutvwG5TImSMAQJS5piVu3js2L9t9TQq1A7Gb9Wi4jdA39V70
n990MUumYckAsZP1tjeDLGBZg67GoOkeHgKBrub2AyG2qXj7VvG6hrxy+vSbEpy6
RSZ/EKdSsRRJ6VVrbF5ScK2HremYFv+sexAXyhv14u1jA8qbawXKM7HGJqyo5PGq
KoRja9uExHy9NPKzpcPgYc/HI+O6CJu7s7M7holP5UFhdy1TwICo1HEbz0orFkO8
XZ6wLFK8PeuuPlto0VPbTWbhaZLDHv4rfThKBMbqlnqlOH94OKyXdU9cqBzAXWeP
NPj13alqfEa4gj5Eo8817DNXvgEd8y3ITBeETmVwviGRLTkb0ZZ7YQf7M2JhIiU0
70+Wc72aH1g8Btk00bhJVY0Q/y4unpYJazVnzxEiGA==
=tVUh
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

