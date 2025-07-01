Date: Tue, 1 Jul 2025 15:51:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aGPn76OGbp-DGqcN@...1296...>
References: <20250701124744.259472-1-ralf@...2726...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7q4mCnLVpE+9P6xb"
Content-Disposition: inline
In-Reply-To: <20250701124744.259472-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: reset GSO metadata
 after decapsulation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

--7q4mCnLVpE+9P6xb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Tue, Jul 01, 2025 at 02:47:44PM +0200, Ralf Lici wrote:
> By calling skb_gso_reset(skb) we ensure the inner packet is presented to
> gro_cells_receive() with a clean slate, correctly indicating it is an
> individual packet from the perspective of the local stack.

Amazing find.

I have tested this on my ubuntu 20.04 (backports) testbed that had the
"large ping tcp instance -> udp instance fail", and now everything succeeds
(this patch applied to "DCO version: ovpn-net-next/net-6.15.0-8f0bda6").

Tested-By: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7q4mCnLVpE+9P6xb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoY+fvAAoJEB2Cnv7KVigSrZML/0zvZInhwKFa5UVJltYM1MfA
vCoI1G6zmkcMC7fDILj4vL0TJCkF7H8/QILpY/Cm6uE1rpyJci4bp4NJEOBOetYl
YT9dvM2jWPViaLLrHib25rAqSSPazJUYrRpNodoHCRKHe0W7wMQzw47i1aBV0cgT
8Ryf1+hkNbX8eXP3zzgb22uJjhqUPDIt7KlKpanBVxyU9zGjfb2kXMWhmoyYEdP1
Gm38KmH+PvmdPsyHHfTrpLrbDSosa4ZTW9JQA3m0L5K5aL5b29vpAEhseDqqNGXY
nc1meUlwfxgXLAerWGVRwC5IvB3BbEduRQgY1s3rZC+TwpHQ62MTDnNygha6A+/Y
cu3hFG06bJxwx7xgsK/xPL7hJ1SM8jBAOCKDX+G0Uzlv2swoWvGWwBwtDil2zM7T
XOKEq8P/YaV1cH5IAYesH3DxbQ2uUwCnvg3nXNFrw6sUdOB3LazxO3LEks3Lhhj/
QUJEXW/2IFmR39NH1aroPESfCqCxq/LF/VogxYDNIA==
=fHAR
-----END PGP SIGNATURE-----

--7q4mCnLVpE+9P6xb--

