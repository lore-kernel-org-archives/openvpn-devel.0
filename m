Date: Wed, 21 Apr 2021 22:32:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210421203205.GF976@...1296...>
References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rQtJvOkhCe9+IMgh"
Content-Disposition: inline
In-Reply-To: <20210421134348.1950392-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/7] Remove support for blocking
 connect()
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

--rQtJvOkhCe9+IMgh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 21, 2021 at 03:43:46PM +0200, Arne Schwabe wrote:
> It is hard to imagine that we still have any supported OS that does
> not support non-blocking connect while still supporting non-blocking
> sockets in general.
[..]
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index f29c63c73..a964ffd35 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -155,10 +155,6 @@
>  #include <poll.h>
>  #endif
>=20=20
> -#ifdef HAVE_SYS_EPOLL_H
> -#include <sys/epoll.h>
> -#endif
> -

Is that intentional?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rQtJvOkhCe9+IMgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJggIvFAAoJEB2Cnv7KVigSwuQL/jYRItzdVy4luNJ1rTY3WKXm
Id804pDl6wOLJwGHrookP6gp6hIAwdMWPt7rANdhAtEESzjm0jWpqkfFWLZ7JlLJ
t6H+L0UhCWwO1Gv4a+9VkQGrjkpigDT5HC8YoI8JoGGgUQB/xRFznWNQZz1XNDCr
jJuLN488C7/WtVB5HXk8lLeADm8SXQVzEGN0vtNTnrOjEE9GkEiTDb5Bra8eRyVn
nMs1vzfR83SWFf1RCgk1VTVfYasCMfhfmPu++kcOAxU6mO3wvtbJvorLVfdxEfJM
DPEz67XRZN376SvjO4w/fxmJZH+Zwy7FCayQCDTEiQNEuMLJkDHa6BXeSEzGqtxI
CawI5fUF/I4BcrfeL2rivAl4i4HARJAxxh3tTaMBQveC9Pd/m5k41d6iqlczzr0X
V60KTFTWyYSctUxibNZrU5oUXiUGIzW9yggmHZYNy6m01dUsXQJFT3ZmEaUzCzRZ
UWu00WGhI0K2gNiZtvnSekyKk1kWSuee1IBBQ3X5dQ==
=nSZy
-----END PGP SIGNATURE-----

--rQtJvOkhCe9+IMgh--

