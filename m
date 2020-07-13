Date: Mon, 13 Jul 2020 17:38:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713153814.GE1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-12-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xDQK15gv02cLyV00"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-12-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 12/14] client-connect: Add deferred
 support to the client-connect plugin v1 handler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--xDQK15gv02cLyV00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:53AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> Uses the infrastructure provided and used in the previous patch to provide
> deferral support to the v1 client-connect plugin handler as well.
>=20
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
>=20
> PATCH V3: Modify the API to also (optionally) call the plugin on a deferr=
ed
> call. This allows the plugin authors to be more flexible and make the V1 =
API
> more similar to the V2 API.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

I think this should get a feature-NAK.=20=20

Plugin v1 is old, and nobody should be developing for this API anymore.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xDQK15gv02cLyV00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDH/mAAoJEB2Cnv7KVigSAWcMAJQ0F4RPv2hVZefsP2f2LOhc
PNW0f0+KQeGjlOOTtMioxqU8qlooG5Cwl6QBHIn3A4Ve/3B3T/o9SJomHWZldjOn
QEcLiKMbtvnBW9oNPfUhTcYFpXNZI1pBrBMmWyuKuB5IjuSTuTxX08P+R+Rz7ax4
l09XGusSLdC7MM/cxAve1n/zY/Z4zZBaOmRARlqlMnyZxFLkQkpWsV0uEkFxY8mZ
cdV38Zua3sW7LzB6KLDKFJzOM78a6cGwsLad3qdSkLxvlbtKxkEdX4ahqMFVgDH2
zCyAkSDshq3MZlLY6ioD1t0bGFS7jn2BpNBqgVpvuCfHG9+UGfOPuRInZcR215hX
IXxu/L2ONw0iFKima799ta7dc8zG9CAURlBb38cVU23EejIz8IeBc/aYh+ADYV20
gBxZmzoX0L7cmQ0yzlQuUb5mtopTWoHcKKyGgBS7WAxqHudaJd313C4UEftdiYyF
PdfsOjJZtvaLAJ00nJzjsy1ZNvW3qbprOgznLbaoMw==
=wLEX
-----END PGP SIGNATURE-----

--xDQK15gv02cLyV00--

