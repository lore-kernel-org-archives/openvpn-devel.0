Date: Tue, 10 Jan 2023 14:42:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y71rPELRzb+Y2Ogd@...1296...>
References: <20221227022404.3468137-1-arne@...1227...>
 <20221227022404.3468137-4-arne@...1227...>
 <Y6rFHLYF9AYpBG+d@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="j7S+wprgBD5eRI6K"
Content-Disposition: inline
In-Reply-To: <Y6rFHLYF9AYpBG+d@...1296...>
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

--j7S+wprgBD5eRI6K
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 27, 2022 at 11:12:44AM +0100, Gert Doering wrote:
> Playing around with the patch a bit, the offending piece seems to be
> "mi->context.options.verbosity >=3D D_DCO_DEBUG" - which is unsurprising,
> as D_DCO_DEBUG is not "6" but "LOGLEV(6, 69, M_DEBUG)", which translates
> to=20
>=20
>   #define LOGLEV(log_level, mute_level, other) ((log_level) | ENCODE_MUTE=
_LEVEL(mute_level) | other)
>=20
> (numerically, D_DCO_DEBUG =3D 1157628038)

... looking at error.h, there is a "check_debug_level(flags)" thing, so
changing the condition to

+        if (mi->context.c2.tls_multi
+            // && mi->context.options.verbosity >=3D D_DCO_DEBUG
+            && check_debug_level(D_DCO_DEBUG)
+            && dco_enabled(&mi->context.options))
+        {
+            buf_printf(&out, " peer-id=3D%d", mi->context.c2.tls_multi->pe=
er_id);
+        }

works - "if --verb 6 or higher, *and* DCO, then have peer-id=3D%d as part
if the prefix".

Can you resend a v3?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--j7S+wprgBD5eRI6K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjvWs8AAoJEB2Cnv7KVigSSDEMAK3/OjkAq0YOcIuPa2RIKKSe
s/4WUeliUT1FHNQq/LGgnC1iIRvmdQUKzjGnn1cJWs5LemIPQN+VoJiO3tbDrV+s
4HTgAAETsSwpn3m+4lYV1WgABc2lMk7qflJixc/RvBhk/3TlYe4uqphbvfMNjOkO
nfirfvqosecZ6nOhkxo70rH0sz1Kd8U6qW3OWibV2fk1P8EXlddtHGZ+YtZ7ImWc
113z1qm+4CF92Zx9BfVdEl3uWHLr2PxYEJsXmElxZ+cK1AR8kuQPm055yvuh0R6J
8cmlgJlGcoBFgtc8iahvmfArlTbRz+m+TATKXu2iw1Sru/phGP/xxBvf7yqxei4T
s3YQh6giSuThcql43k/S+Rx31GjuFoHT9mvDWLpKwJuEmF0iJlgPvAnE+ZTGEE4d
LJek9hHp+jcAInqw0Kxh6RkJZFRlcnskg7vuVPDouc6TgAR3kgo/iU7NYJPYFhwl
DUaHoPkqV0v6hCHsvGjRf4sJrM8othW5SjBfffARMA==
=qDjY
-----END PGP SIGNATURE-----

--j7S+wprgBD5eRI6K--

