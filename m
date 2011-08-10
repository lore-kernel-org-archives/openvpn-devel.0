Date: Wed, 10 Aug 2011 22:31:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110810203141.GA8496@...1296...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e59Ae4BottLx1djM"
Content-Disposition: inline
In-Reply-To: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] fix building for WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--e59Ae4BottLx1djM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 10, 2011 at 12:55:06PM +0000, Heiko Hund wrote:
> struct in6_addr.s6_addr32 are not available there.

I've sent a fix for that one to the list some two months ago, but it's
stuck somewhere in the commit queue...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--e59Ae4BottLx1djM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTkLqrakuBuNlUUl1AQL28QP9EjMSI10z2UBPpWuB7YBKhT1CVTwmNddr
O6tIvfoSTYr4TrR9VPcGhUILHzaZSc6B/92YWkElEwb22HMHFjHTDxNeUC3jzbjl
IWjBsb2enbgzdR7aWTNV2D6X+K4q3aihyWAK65h8kw3i/BQuIEtmEH7fonugVIUV
V+cL5K8Mu4k=
=iCoy
-----END PGP SIGNATURE-----

--e59Ae4BottLx1djM--

