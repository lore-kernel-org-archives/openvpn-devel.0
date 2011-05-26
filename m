Date: Thu, 26 May 2011 15:53:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110526135308.GU8496@...1296...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
	<1306416185-4901-2-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WpBsPuQsCdPBgAv4"
Content-Disposition: inline
In-Reply-To: <1306416185-4901-2-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Fixed a number of fatal build
	errors on Visual Studio 2008
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

--WpBsPuQsCdPBgAv4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 26, 2011 at 04:23:02PM +0300, Samuli Sepp=E4nen wrote:
> Partially fixes ticket #137
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
> Tested-by: Samuli Sepp=E4nen <samuli@...515...>

NAK, something went wrong here.

> --- a/helper.c
> +++ b/helper.c
> @@ -143,6 +143,12 @@ helper_client_server (struct options *o)
>  #if P2MP
>  #if P2MP_SERVER
>=20=20
> +/*
> +   * Get tun/tap/null device type
> +   */
> +  const int dev =3D dev_type_enum (o->dev, o->dev_type);
> +  const int topology =3D o->topology;
> +
>    /*=20
>     *
>     * HELPER DIRECTIVE for IPv6
> @@ -220,12 +226,6 @@ helper_client_server (struct options *o)
>     *   push "route-gateway 10.8.0.1"
>     */
>=20=20
> -  /*
> -   * Get tun/tap/null device type
> -   */
> -  const int dev =3D dev_type_enum (o->dev, o->dev_type);
> -  const int topology =3D o->topology;
> -
>    if (o->server_defined)
>      {
>        int netbits =3D -2;

This is OK.

> diff --git a/socket.c b/socket.c
> index 6b855c0..3d4801f 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -3156,6 +3156,8 @@ link_socket_write_udp_posix_sendmsg (struct link_so=
cket *sock,
>   * inet_ntop() and inet_pton() wrap-implementations using
>   * WSAAddressToString() and WSAStringToAddress() functions
>   */
> +
> +/*
>  const char *
>  inet_ntop(int af, const void *src, char *dst, socklen_t size)
>  {
> @@ -3204,6 +3206,8 @@ inet_pton(int af, const char *src, void *dst)
>    return 0;
>  }
>=20=20
> +*/
> +
>  int
>  socket_recv_queue (struct link_socket *sock, int maxsize)
>  {

This is not.  Our local implementations of inet_ntop and inet_pton=20
are needed for msys/mingw and conflict with MS VS, so they need to
be there, but conditional on _MSC_VER.  So this should be:

#ifndef _MSC_VER
...
#endif

> diff --git a/win/config.h.in b/win/config.h.in
> index 82344a0..ec447a2 100644
> --- a/win/config.h.in
> +++ b/win/config.h.in
> @@ -275,7 +275,7 @@ typedef unsigned long in_addr_t;
>  #define inline __inline
>=20=20
>  /* type to use in place of socklen_t if not defined */
> -#define socklen_t unsigned int
> +/*#define socklen_t unsigned int*/
>=20=20
>  #ifndef __MINGW32__
>  /* 32-bit unsigned type */

This needs to be tested whether it still works with mingw/msys - I have
my doubts.  So this change also needs to be conditional=20

#ifndef _MSC_VER
#define socklen_t unsigned int
#endif

(or vice versa, "#ifdef __MINGW32__").

> diff --git a/win32.h b/win32.h
> index d0ecc85..3b26bb1 100644
> --- a/win32.h
> +++ b/win32.h
> @@ -272,8 +272,10 @@ char *get_win_sys_path (void);
>=20=20
>  /* call self in a subprocess */
>  void fork_to_self (const char *cmdline);
> +#ifdef _MSV_VER
>  const char *inet_ntop(int af, const void *src, char *dst, socklen_t size=
);
>  int inet_pton(int af, const char *src, void *st);
> +#endif

NAK, this needs to be "#ifndef _MSC_VER"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WpBsPuQsCdPBgAv4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTd5bRKkuBuNlUUl1AQI/vQQAu3bK12eWaq9c6Udh5v/9c/6YgREMlhrK
o+E0I2Qix0WZm2L/L+0FBvlosFav0LzkkZaaVpHcL8t87YKi0RpNuXN+2RIGRxlY
/1jnoEiZdDDq1dCDvRpjh/+PeOXGBxiC1JCjIOVTiRI3iQMn1TU2B6BKY7x06Cnf
1UpoiMm+R5o=
=uiyZ
-----END PGP SIGNATURE-----

--WpBsPuQsCdPBgAv4--

