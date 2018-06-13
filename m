Date: Wed, 13 Jun 2018 13:06:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180613110630.GO57262@...1296...>
References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-2-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yFaVioVr1PXjCrcB"
Content-Disposition: inline
In-Reply-To: <20180613081218.1834-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] tun: ensure gc and argv are always
 freed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--yFaVioVr1PXjCrcB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 13, 2018 at 04:12:15PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> Everytime a argv object is initialized with argv_new(), it has
> to be released with argv_reset() once not needed anymore.
>=20
> The same holds for gc_arena objects initialized with gc_new() that
> have to be released with gc_free().
>=20
> Ensure both kind of objects are always properly released to avoid
> memory leaks.

This is good housekeeping.  Still, I need to NAK this, because I never
agree to anything on the first go ;-)

Specifically...

> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/tun.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 3eb0f78a..466d4d42 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -2615,6 +2615,8 @@ close_tun(struct tuntap *tt)
>          openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun inter=
face' failed (non-critical)");
>=20=20
>          free(tt);
> +        argv_reset(&argv);
> +        gc_free(&gc);
>      }
>  }

While this is technically correct, the gc_arena is not used at all in=20
this close_tun() instance (OPENBSD).  So, please do not add a cleanup call,=
=20
but just remove the "struct gc_arena gc =3D gc_new()" call instead.

The same holds for the NETBSD and AIX variants - gc/argv initialized, but=20
only argv used.  So, please remove gc_arena instead :-)

(Side note: the FREEBSD close_tun() variant is mostly the same, but does
not have a gc_arena ... seems someone already stumbled across that one
and fixed it)


ACK on the remaining AIX argv_reset() - oops, that was me :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yFaVioVr1PXjCrcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbIPq2AAoJEB2Cnv7KVigSdTYMAKYvj5v4uFu6wWQir3t/WNdK
KyBOcrxst/FcrqrEyUIDJfhhvMsak6qfh5MSS/4Sarj9ZicG2e9j7Q2g7YfF7ebP
zJnRnXztrgBGmdjuS8ndBgTTDCXWYoBIEKPnMCkP4hJTpNWLvyiMySePK0ZRYjc9
6ZfHqC1/2VAamKJluxS8hvURguptRz0YKIduF0TBnTZfpOGCheyqQRnoGsG3arRN
yKbyqVzy3gxAWxQ9VWwfDUXdjIVMz61ISPFtv5LzaydVOnQhao8SlrnfORPhUwng
7uoaI87gqrtfFgRphcB+pXLJp8ea98xpmkSmKj6A7BZ06zk0hAjXRFt1DviSGuA/
FTbQ9hZdLi6mw8U9uvI8/1gAdg5xH0gZIY5obqyrlpkfYra33tBuAckuteAvFgl1
/0ovN0Bv/PIxB/kT0U7/zKCzOaz2UjgLjH/w8Ipwfck2/Emt44Va6dvwXnywQhbx
qgpa98TVRqeO5ZIiuAfNNEcMjEY2KpxIgz8prdBXGg==
=0lVl
-----END PGP SIGNATURE-----

--yFaVioVr1PXjCrcB--

