Date: Tue, 27 Mar 2012 16:24:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120327142418.GE1359@...1296...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-2-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hKnd/qOzIOdPs36Y"
Content-Disposition: inline
In-Reply-To: <1332797200-9295-2-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] build: openbsd: detect netinet/ip.h
	correctly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--hKnd/qOzIOdPs36Y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 11:26:35PM +0200, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index a30e873..b0dcdb7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -395,6 +395,9 @@ SOCKET_INCLUDES=3D"
>  #ifdef HAVE_WS2TCPIP_H
>  #include <ws2tcpip.h>
>  #endif
> +#ifdef HAVE_NETINET_IN_SYSTM_H
> +#include <netinet/in_systm.h>
> +#endif
>  "

ACK.

(It gets the job done, and is consistent with what we have right now.=20=20
Wether or not I think we could do with "less stuff done in configure"
is a separate discussion and needs not affect *this* patch).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hKnd/qOzIOdPs36Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3HNkqkuBuNlUUl1AQI64wQAo+PW0Le89mCxpyuQDaOU4qjFt49Jfr5H
yPURyq6dfjHjEIGMw6EGHps7hzGhCn58Pr94B7GQgJ2ufzcQfbiYTGIzFuxzhbCf
ant3xiM/++A6I0nQnjWMfYOrdlkC146mZV7tJUGA4GGGsPCEyaUBHaoGZC8huP/7
fBl2iVL4ynE=
=SbuP
-----END PGP SIGNATURE-----

--hKnd/qOzIOdPs36Y--

