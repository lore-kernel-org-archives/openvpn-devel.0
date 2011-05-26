Date: Thu, 26 May 2011 16:54:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110526145408.GX8496@...1296...>
References: <20110526135308.GU8496@...1296...>
	<1306420529-5959-1-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McdSptj+a/sahpq7"
Content-Disposition: inline
In-Reply-To: <1306420529-5959-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix problems with fixes to socket.c and
	win32.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--McdSptj+a/sahpq7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 26, 2011 at 05:35:29PM +0300, Samuli Sepp=E4nen wrote:
> Signed-off-by: Gert Doering <gert@...1296...>
> Tested-by: Samuli Sepp=E4nen <samuli@...515...>
> Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
> ---
>  socket.c |    5 ++---
>  win32.h  |    2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/socket.c b/socket.c
> index 3d4801f..b1160d7 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -3157,7 +3157,7 @@ link_socket_write_udp_posix_sendmsg (struct link_so=
cket *sock,
>   * WSAAddressToString() and WSAStringToAddress() functions
>   */
>=20=20
> -/*
> +#ifndef _MSC_VER
>  const char *
>  inet_ntop(int af, const void *src, char *dst, socklen_t size)
...

ACK!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--McdSptj+a/sahpq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTd5pj6kuBuNlUUl1AQKnjQP+M0fOsBV4/dyvlomQlbydP9cluyu7viv1
+vnlcQrUm4EpKFs+MrTEuoAGhKV/uokMQViOs5D0zp5Nvmdul0t1kYatwQ50JxO7
j/rEt1APRj0GXqd/5uRt8CYIrJ7xnwhiJaQ0XZGIrUXuhpyx5uUs2HXaalEUoxBV
VN6sCJCFink=
=0NSF
-----END PGP SIGNATURE-----

--McdSptj+a/sahpq7--

