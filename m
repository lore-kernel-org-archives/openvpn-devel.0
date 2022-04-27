Date: Wed, 27 Apr 2022 19:35:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yml++SXoDj2uuCi/@greenie.muc.de>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-8-arne@...1227...>
 <Ymlys4bx/rIfg3/5@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yFvA1bjYKzptHpOU"
Content-Disposition: inline
In-Reply-To: <Ymlys4bx/rIfg3/5@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 17/28] Implement constructing a control
 channel reset client as standalone fucntion
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

--yFvA1bjYKzptHpOU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 27, 2022 at 06:43:31PM +0200, Gert Doering wrote:
> [  ERROR   ] --- ASSERT: buf_write(&buf, &net_pid, sizeof(net_pid))
> [   LINE   ] --- ../../../../openvpn/src/openvpn/ssl_pkt.c:425: error: Fa=
ilure!
> [  FAILED  ] test_generate_reset_packet_tls_auth

It needs this hunk from 18/28

+struct tls_auth_standalone
+init_tas_auth(int key_direction)
 {=20
     struct tls_auth_standalone tas =3D { 0 };
+    struct frame frame =3D { {.headroom =3D 200, .payload_size =3D 1400}, =
0};=20=20=20
+    tas.frame =3D frame;

... and then the tests pass.  (This is not really surprising, as it
fails buf_write() =3D=3D the buffer is too small, and without .payload_size,
it will be zero-sized...)

Can you move that one over, rebase, and send 17 v2 + 18 v2?  (18 will
also benefit from rebasing to partially already whitespace-fixed master)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yFvA1bjYKzptHpOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiaX75AAoJEB2Cnv7KVigSDVgL/AnAzUEThUQokACFF5+Z8dsn
WIgQaerdGHh9SoQSiVZ4cidhLPzYWcB+cdA0w6pPAlluWWoKtW3RJlttBxfeoFJs
AoZm1oE62oR/ewOskiV1kJ1Wa0n/gnezW58jieIA5KQ64k+WLM32ncEvsF22Gfaj
frR66kw+EdVnIOZctinYOM6dA0YDjGImmv2OEkyLs9Rzf2RcC+KiYYkEhPRU6CPC
W7IeH1e0fRCY8lsj+sXJkUGBqqojijZrSI2jqgpw4bSjkAjOtwZ/t+TdGJT4H6Sc
QQsQAc7P+6XJa+8yvP79nziVpWTS+eUCWkZTIItqgA0j5xzJ8/e2AMh36NZxbgtl
MdYZizbG/BG5bXMyEx54FGolWkvg4bVM6pB1uRtFhmTnvrUvJJWs4xe15pvdAelB
fta+6x+uU3KiefHGPmv/WlcAEKGyeCCKkydBxD3a0LdyXIkwIK0AT2SzXnQ9WzMC
T2JJEiVjTms0IdmMwdpPgfx3MUA9QErGgZMRC/r2Cw==
=f5Rl
-----END PGP SIGNATURE-----

--yFvA1bjYKzptHpOU--

