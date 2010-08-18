Date: Wed, 18 Aug 2010 17:12:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100818151209.GZ9777@...1296...>
References: <1282143987-24356-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
In-Reply-To: <1282143987-24356-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] More t_client.sh updates - exit with
	SKIP when we want to skip
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 18, 2010 at 05:06:27PM +0200, David Sommerseth wrote:
> Several places we exited with 0 instead of 77 when we want to indicate
> that we should skip this test.

ACK.  Thanks to Matthias for pointing this out.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTGv4SakuBuNlUUl1AQJ17QP/X+NXTu80Gaq0tu2aTap1TTlWA4FNx+Le
0TC7h0de2gnnJpSUK5CnOYHSgp3VNEhM0B4QQvR0naWZUVXXM+y4Nn0ZVbMzG+tP
NBV62Mb6+5aIfMw3atlhP9U3d3qWpf9RR2POzfu0tL2C3xptSA/tV3/YdqE9sb+e
jJnkPFUfWYs=
=7oot
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--

