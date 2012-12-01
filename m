Date: Sat, 1 Dec 2012 14:44:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121201134405.GL22465@...1296...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+xDcZ1j08+V/OfU"
Content-Disposition: inline
In-Reply-To: <1354303076-13606-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 01/10] Remove dnsflags_to_socktype,
	it is not used anywhere
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--J+xDcZ1j08+V/OfU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

ACK, this can go into 2.3 - dead code removal.

gert

On Fri, Nov 30, 2012 at 08:17:47PM +0100, Arne Schwabe wrote:
> ---
>  src/openvpn/socket.c |    2 +-
>  src/openvpn/socket.h |    5 -----
>  2 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 505cf3b..21a4b2b 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -158,7 +158,7 @@ openvpn_getaddrinfo (unsigned int flags,
>    CLEAR(hints);
>    hints.ai_family =3D ai_family;
>    hints.ai_flags =3D AI_NUMERICHOST;
> -  hints.ai_socktype =3D dnsflags_to_socktype(flags);
> +  hints.ai_socktype =3D SOCK_STREAM;
>=20=20
>    status =3D getaddrinfo(hostname, NULL, &hints, res);
>=20=20
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 44f1098..9cb01fa 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -478,11 +478,6 @@ bool unix_socket_get_peer_uid_gid (const socket_desc=
riptor_t sd, int *uid, int *
>  #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
>  #define GETADDR_RANDOMIZE             (1<<9)
>=20=20
> -/* [ab]use flags bits to get socktype info downstream */
> -/* TODO(jjo): resolve tradeoff between hackiness|args-overhead */
> -#define GETADDR_DGRAM                 (1<<10)
> -#define dnsflags_to_socktype(flags) ((flags & GETADDR_DGRAM) ? SOCK_DGRA=
M : SOCK_STREAM)
> -
>  in_addr_t getaddr (unsigned int flags,
>  		   const char *hostname,
>  		   int resolve_retry_seconds,
> --=20
> 1.7.9.5
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Keep yourself connected to Go Parallel:=20
> TUNE You got it built. Now make it sing. Tune shows you how.
> http://goparallel.sourceforge.net
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--J+xDcZ1j08+V/OfU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBULoJpakuBuNlUUl1AQJ8tQP6Ag+y940WrEW/dIGTKCBTW+Xw6+6O0lYG
Ggz+ORF/bML9fGQLwEJIOZYTgbaLihejSwl7Y8JviyW/xq+FiOcVM2Ee/zydDt2E
e2/Kc4/dEIhs2YbA47y5mVxB3dAe4O+prQFcKUIkIdbh9Y/ClXx9gXiXRoLrVZNA
NCJq+8tpXz0=
=KLV7
-----END PGP SIGNATURE-----

--J+xDcZ1j08+V/OfU--

