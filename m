Date: Mon, 1 Dec 2014 09:10:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141201081003.GI17158@...1296...>
References: <1417366536-27057-1-git-send-email-steffan@...1856...>
	<CAAA5faGYtBcupVxqNznNomMiwstEJm1BVskiccVSX=RWsD4GbA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jo46wx5DSA4a/gWG"
Content-Disposition: inline
In-Reply-To: <CAAA5faGYtBcupVxqNznNomMiwstEJm1BVskiccVSX=RWsD4GbA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove ENABLE_SSL define (and
	--disable-ssl configure option)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Reinoud Koornstra <reinoudkoornstra@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--jo46wx5DSA4a/gWG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 30, 2014 at 04:08:12PM -0700, Reinoud Koornstra wrote:
> Will this change be in 2.3.6 that'll be released tomorrow?

No.  2.3 series will get bugfixes, and "small" new features that are
considered important for long-term stability.

This patch is primarily refactoring to ease code maintenance and testing,
so it goes into 2.4

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jo46wx5DSA4a/gWG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVHwiW6kuBuNlUUl1AQINHwQAhxVQYvZYGqOeV3Il8aAhOsvPayTWhO9J
1vdfqSdpr25fI/XuJnSsGLEfR4HiqzJrLPCrEbTJNzKtFVaCtry8BA0VVrHxoH04
LZJ5XjcUHHi9O4u2g/ew7tnIfaKm9of6dWiOJOCZUS5pR+gYBkgIc9tx+8nrcqXw
6qZGPGqrvzU=
=6DQq
-----END PGP SIGNATURE-----

--jo46wx5DSA4a/gWG--

