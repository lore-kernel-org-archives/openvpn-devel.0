Date: Tue, 27 Dec 2022 11:12:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6rFHLYF9AYpBG+d@...1296...>
References: <20221227022404.3468137-1-arne@...1227...>
 <20221227022404.3468137-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5DYUINHufALTawv9"
Content-Disposition: inline
In-Reply-To: <20221227022404.3468137-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/4] Log peer-id if loglevel is
 D_DCO_DEBUG and dco is enabled
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

--5DYUINHufALTawv9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 27, 2022 at 03:24:04AM +0100, Arne Schwabe wrote:
> This enables logging the peer id in p2mp mode if dco is enabled
> and the log level is high enough

Ho hum, this does not work for me...

TLS/TCP server, DCO enabled, --verb 6...

2022-12-27 11:05:41 us=3D111855 something/194.97.140.21:16006 dco_do_write:=
 peer-id 0, len=3D390
2022-12-27 11:05:41 us=3D111931 something/194.97.140.21:16006 dco_update_ke=
ys: peer_id=3D0
2022-12-27 11:05:42 us=3D173611 dco_do_read
2022-12-27 11:05:42 us=3D173764 ovpn-dco: received OVPN_PACKET_ATTR_PACKET,=
 ifindex: 32018 peer-id: 0, len 22
2022-12-27 11:05:42 us=3D173825 something/194.97.140.21:16006 TCPv6_SERVER =
READ [22] from [AF_INET6]::ffff:194.97.140.21:16006: P_ACK_V1 kid=3D0 [ 5 ]=
 DATA len=3D0
2022-12-27 11:05:42 us=3D267059 something/194.97.140.21:16006 dco_update_ke=
ys: peer_id=3D0
2022-12-27 11:05:43 us=3D423410 something/194.97.140.21:16006 dco_update_ke=
ys: peer_id=3D0
2022-12-27 11:05:58 us=3D584121 something/194.97.140.21:16006 dco_update_ke=
ys: peer_id=3D0

... there *should* be a peer-id somewhere in that line...

Playing around with the patch a bit, the offending piece seems to be
"mi->context.options.verbosity >=3D D_DCO_DEBUG" - which is unsurprising,
as D_DCO_DEBUG is not "6" but "LOGLEV(6, 69, M_DEBUG)", which translates
to=20

  #define LOGLEV(log_level, mute_level, other) ((log_level) | ENCODE_MUTE_L=
EVEL(mute_level) | other)

(numerically, D_DCO_DEBUG =3D 1157628038)


The test for dco_enabled() works.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5DYUINHufALTawv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqsUcAAoJEB2Cnv7KVigS5uIL/1i2lvYkJYFU0pTr5QuDefmF
WuPaRtkj1sibf0z+zzhPiDqfOgSTsk3a1XQ1A8KnmrWQVq45F8rvxoDYNZXzFumE
jcrAtvIXcYQ0Yo97acy7rKetx8eEqDJjYqAISlqp2KG63L4BgJ14w6l4C+2Jqcke
KTX/h9G7kg1Z01DNVHbpELwpq+zETmSkJdL/MWWvPO0VOHY0n5LISnVID/0x7yUx
PuDOpavbSmZ5UPFPS9/vo7h4Y9TSylkdYx8UmzrfFvR/O8rIyHdHbLfIeTl3kYQU
P+PtILdU6iuikbBZS0KXGlAbYc2p/qrpTcnuf0+i3GXZfbfyPnhMUJzGtTMVdnQz
I2PxmlGeHvuo7gcVIWYAI4E5BASlFqhv/+VTlSpU5Fp3PAJ3vTfK4hyMIsKxJoJ4
J4BWTxCjr/2eBTxXIYwb8qSo8jfXdD6e5XHOXMQbdsXojmdT6PBP/wqYrz7zSfnQ
7rsziexlVnpsvFSCXkyl6WSk4p1cV/KCFcZUmGFG+A==
=s+Hh
-----END PGP SIGNATURE-----

--5DYUINHufALTawv9--

