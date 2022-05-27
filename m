Date: Fri, 27 May 2022 13:40:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YpC4yTOjnZr2EGvF@...1296...>
References: <20220527113411.1846837-1-heiko@...2662...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cqAC3ordQIIwBevV"
Content-Disposition: inline
In-Reply-To: <20220527113411.1846837-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] include unistd.h for _exit(2)
 declaration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--cqAC3ordQIIwBevV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 27, 2022 at 01:34:11PM +0200, Heiko Hund wrote:
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>  src/openvpn/error.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index 972619fe..76308560 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -33,6 +33,8 @@
>=20=20
>  #if _WIN32
>  #include <windows.h>
> +#else
> +#include <unistd.h>
>  #endif
>=20=20
>  /* #define ABORT_ON_ERROR */

<unistd.h> is included by "syshead.h" already today, with a nice
HAVE_UNISTD_H wraper (thus, not depending on a "if it's not WIN32,
it surely must have unistd.h" assumption).

So I wonder what issue this fixes?  I see no compile time warnings about
_exit() either.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cqAC3ordQIIwBevV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJikLjJAAoJEB2Cnv7KVigSl/gL+gJ6rDc+VLGriBjInskkzLjZ
8UH9YssfYSEF5jytf4l7H7riJwHb57CPD5fIBFWTO0Ri4kwHFXt36ycv2GMFfd4+
MXVmQ+l4XQu/XLTLUnnSDjQWxohxentcas8u1XBCfpHp6Tq5AkUdoP+7VRkyYtgA
4jHxETEEedHKFPLHzhdawytQwq+Cy0ObJ07DDzZgACR1CbhZRdpwYDL13ce/7IQU
LwslBOaCFqDR5p+IiHLcPlSRKE2JThR1w6P78ux4MAYJ3qNh0XPnsje+eWJyGINj
Mr+0TGBDXjynH015U1rdmZ+xbis3rvPVg11LaUQqOiy2H+pYg5zsk8RU+o5KhRtJ
p54q+etcdeFlXwZKz5l4R/eS/5IYZ3NBB1a6ISZTyjWGscWMthBBtUz/gqfONWjY
i08Qy2SXrcSjv3HVr+iDz/p+hOZJmWuRgcqQqpUe2pdwHxU45WVIOKcVN7jY/VBy
4NfMr11JmxkmBKkAgq2wb9NALe6AScm2dxa0gvZ5rQ==
=qKun
-----END PGP SIGNATURE-----

--cqAC3ordQIIwBevV--

