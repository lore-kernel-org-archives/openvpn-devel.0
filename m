Date: Wed, 7 Dec 2016 22:07:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161207210745.GA34816@...1296...>
References: <1481138447-6292-1-git-send-email-steffan@...1856...>
	<b6160324-4b05-6949-dcfa-ac204e94124e@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <b6160324-4b05-6949-dcfa-ac204e94124e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --no-iv
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 07, 2016 at 09:51:16PM +0100, Arne Schwabe wrote:
> > +- ``--no-iv`` is deprecated in 2.4 and will be remove in 2.5.
>=20
> Typo: removed

Since I had not pushed it yet, I've changed Changes.rst to fix that,
and added your Acked-By:

The new commitish is now

commit 4969f0d6bba8a82d411f0700c2e8e4efbeccb6c8
Author: Steffan Karger <steffan@...1856...>
Date:   Wed Dec 7 20:20:47 2016 +0100

    Deprecate --no-iv
=20=20=20=20
no other changes to the original patch.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYSHohAAoJEB2Cnv7KVigScbUMALCSLMcYcLB+VB0ux/ot3yGG
NQNLMZi8ArzdBHx+fsGIkcMvo5Iy3M9cFb9vDx+AIm6yFxr2t2pqAO9AInnEql3k
Xsrz+wo8urTclmlhMkLVfTSOuMiXFY1kbR8tt6qGKUedM4x7uiX+Hbey316Scz8o
3ewMKiTHg9x6O7qcHvvZpX86bbXRalGVWwMJkh/3nAsWqiI/sA4m7fsevAPx8k3S
+urh1pZifSyPwvxN3W6Dqc//GHzfMQ/oaKzyYph2uhtc4vnvWjSZz1iAu99aJ9w3
297QTclNSFiWWn2D4o3jS0vYSLGO2OlYt7dpbk/kxaSDYDdKCJfHWGSQb6Gn3guc
TFti6JbnOQjcz6CS3i4L76UhI/fDSyBE/Oi5CFUpPyh2N4L/aVzTOFD4MYfbvqwq
5YQr7Noh7Ru6OuHEgsfJnDNf0W6wxV6p7Ne3NLD/4ALl3+5ZhcM9tyuPWRgRQri7
qwPt+5O4kBLhF+nglTaqnTLgWYAvp2nQPBTibVb3Pw==
=q2UE
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

