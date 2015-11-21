Date: Sat, 21 Nov 2015 21:06:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151121200637.GD24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BxZB57hXMgIq1JsC"
Content-Disposition: inline
In-Reply-To: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Pellegrin <chripell@...410...>
Cc: openvpn-devel@lists.sourceforge.net

--BxZB57hXMgIq1JsC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 17, 2015 at 12:32:16PM +0000, Christian Pellegrin wrote:
> Looks better than just adding AF_UNSPEC case but I noted many other
> FIXMEs about AF_UNSPEC that could be solved this way. So let me know
> if there is any reason to not use the ai_family field (and just add
> the AF_UNSPEC case in set_mtu_discovery)

No, AF_UNSPEC in set_mtu_discovery is not the right thing (because it
would have to bei either a no-op, or try ipv4 *and* ipv6 to see which
one succeeds).  We really need to set info.af properly, as your patch
has a little side effect...

> +++ b/src/openvpn/socket.c
> @@ -1670,7 +1670,7 @@ phase2_set_socket_flags (struct link_socket* sock)
>      set_cloexec (sock->ctrl_sd);
>=20=20
>    /* set Path MTU discovery options on the socket */
> -  set_mtu_discover_type (sock->sd, sock->mtu_discover_type, sock->info.a=
f);
> +  set_mtu_discover_type (sock->sd, sock->mtu_discover_type, sock->info.l=
sa->bind_local->ai_family);

... on a client with --nobind, this immediately crashes as lsa->bind_local=
=20
is not set...

Sat Nov 21 21:01:48 2015 OpenVPN 2.3_git [git:master/48c23dc92006e1d8+] i68=
6-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH] [IPv6] built on Nov=
 21 2015
Sat Nov 21 21:01:48 2015 library versions: OpenSSL 1.0.2d 9 Jul 2015, LZO 2=
.08
Sat Nov 21 21:01:48 2015 TCP/UDP: Preserving recently used remote address: =
[AF_INET]199.102.77.82:51194
Sat Nov 21 21:01:48 2015 Socket Buffers: R=3D[110592->110592] S=3D[110592->=
110592]

Program received signal SIGSEGV, Segmentation fault.
0x0809c165 in phase2_set_socket_flags (sock=3D0x80ee270)
    at ../../../openvpn/src/openvpn/socket.c:1673
1673      set_mtu_discover_type (sock->sd, sock->mtu_discover_type, sock->i=
nfo.lsa->bind_local->ai_family);

(gdb) print sock->info.lsa->bind_local
$1 =3D (struct addrinfo *) 0x0


So, overruling Arne's ACK and not applying it :-)


I wonder if the *right* fix for this case wouldn't be to extend this
code block (before calling phase2_set_socket_flags(), socket.c line 1880):

          if (sock->bind_local  && !sock->remote_host && sock->info.lsa->bi=
nd_local)
            {
              /* Warn if this is because neither v4 or v6 was specified
               * and we should not connect a remote */
              if (sock->info.af =3D=3D AF_UNSPEC)
                msg (M_WARN, "Could not determine IPv4/IPv6 protocol. Using=
 %s",
                     addr_family_name(sock->info.lsa->bind_local->ai_family=
));

              create_socket (sock, sock->info.lsa->bind_local);
            }

into...

              if (sock->info.af =3D=3D AF_UNSPEC)
+		{
                   msg (M_WARN, "Could not determine IPv4/IPv6 protocol. Us=
ing %s",
                     addr_family_name(sock->info.lsa->bind_local->ai_family=
));
+		   sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+		}

which would catch your case, but also the "--nobind and we have a remote"
case (client).

Arne, what do you think?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BxZB57hXMgIq1JsC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlDOoqkuBuNlUUl1AQJPWAQAsc6lP1XsdHkUlcDdl/rHsoXzyAJKnSPQ
H/3glM0SH85ZBy/gQySjxnitYGWMpFA96JKC9A/aAAEArV1GnQRrY0mf9rtZD55b
QmdmUcPSMvEnIcm+YuXCo6HHgse0HLd9+Wy+eBfCi4ak4aLxfPYaokWqZT/M/bwA
LT37OYtzIsA=
=r/i1
-----END PGP SIGNATURE-----

--BxZB57hXMgIq1JsC--

