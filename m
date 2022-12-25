Date: Sun, 25 Dec 2022 18:25:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6iHd3KS0LUw0ti/@greenie.muc.de>
References: <20221224194253.3202231-1-arne@...1227...>
 <20221224194253.3202231-8-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W9tm5w9Q6jyF3cmV"
Content-Disposition: inline
In-Reply-To: <20221224194253.3202231-8-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 7/9] Bail out when trying to install a
 TCP socket with residual data to DCO
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

--W9tm5w9Q6jyF3cmV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 24, 2022 at 08:42:51PM +0100, Arne Schwabe wrote:
> Instead of getting the server in a very weird state, we bail out here. Th=
is
> is only a bandaid solution but better than the alternatives.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

Having a clear failure indication in the log and towards the client
is good, so definitely Feature-ACK.

I did also observe this when running the gremlin TCP test last night,
with 4/9 applied

Dec 25 02:49:44 ubuntu2004 tun-tcp-p2mp-username-cn[1828024]: ovpn-dco inst=
alled socket with residual read len=3D0, mi=3Dgremlin84091/194.97.140.21:10=
133. This connection will probably break.
Dec 25 02:49:46 ubuntu2004 tun-tcp-p2mp-username-cn[1828024]: ovpn-dco inst=
alled socket with residual read len=3D0, mi=3Dgremlin84091/194.97.140.21:10=
133. This connection will probably break.
Dec 25 02:49:47 ubuntu2004 tun-tcp-p2mp-username-cn[1828024]: ovpn-dco inst=
alled socket with residual read len=3D0, mi=3Dgremlin84091/194.97.140.21:10=
133. This connection will probably break.
Dec 25 02:49:48 ubuntu2004 tun-tcp-p2mp-username-cn[1828024]: ovpn-dco inst=
alled socket with residual read len=3D0, mi=3Dgremlin84091/194.97.140.21:10=
133. This connection will probably break.

... with a single instance (gremlin84091) having 2905 lines of log - so
this is certainly not a state we want the server to be in (other instances
only show up once, or 4 or 22 times... whatever OpenVPN does here).


This does not apply as it needs 4/9, and *that* one breaks inbound TCP
for me, so postponing this patch until we understand why 4/ doesn't work.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--W9tm5w9Q6jyF3cmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqId3AAoJEB2Cnv7KVigSQ6ML/10+xLNeoNuwe6R5BPnw/lFW
UDCeC1RO+I5GgX3cN2Mu9h3omcQ6pOoHm6YYEHNB2GGC7jO1BswKAcdWjxG5Rnoa
QvLVnMTcyiC9xG+V59nd0DUZAKDCvIu80yMDW7iuVasC2dcqv3rq88KHQpD9PIo+
7G9NMqFFubnJpIcf74SET73yNpB6DK1hafv5dnodFAPAcbCZXixNo0zJ0sH+2eu9
OdhehwRSJNek5ALgjxmakx9vplxT5+CQ9idjCZieune82K4zRd9jDrWj59HsM2et
xWetdI0AC2hdpUDdHbbyMmLpTt8kxze7mRjMm0tTYDe9UBkI42Ubw2tMqfNLsSQy
XenuSNhZx7SyTu2UkvD72K94PmRYPfw8wCcojoigpstXyRULVmZI8azNyPLdrZFc
mc8pHyineYWFGcYJitiXA82YSM5xXjCCfpk+zzWJYaG5IXVc1+y+nMjaYyQPBrC6
/6WL3IdX3fu5OEphebjbP2DG+7V0cODvJYlaENfRTQ==
=Yolp
-----END PGP SIGNATURE-----

--W9tm5w9Q6jyF3cmV--

