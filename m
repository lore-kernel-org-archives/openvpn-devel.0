Date: Mon, 3 Sep 2012 09:31:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120903073131.GM18296@...1296...>
References: <1343837470-3923-5-git-send-email-arne@...1227...>
	<1346657176-9612-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8HhMLSHvAouSipEr"
Content-Disposition: inline
In-Reply-To: <1346657176-9612-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify print_sockaddr_ex function,
	merge duplicate ipv4/ipv6 logic
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

--8HhMLSHvAouSipEr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this looks like it should work both on *BSD and on Linux - explicit
salen parameter, based on sa_family, no special macros (since we have
the switch/case part anyway).

And the tabs are right \o/

ACK ;-)

gert


On Mon, Sep 03, 2012 at 09:26:16AM +0200, Arne Schwabe wrote:
> ---
>  src/openvpn/socket.c |   68 ++++++++++++++++++++++----------------------=
------
>  1 file changed, 30 insertions(+), 38 deletions(-)
>=20
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 505cf3b..a9adf3f 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -2164,60 +2164,52 @@ print_sockaddr (const struct openvpn_sockaddr *ad=
dr, struct gc_arena *gc)
>=20=20
>  const char *
>  print_sockaddr_ex (const struct openvpn_sockaddr *addr,
> -		   const char* separator,
> -		   const unsigned int flags,
> -		   struct gc_arena *gc)
> +				   const char* separator,
> +				   const unsigned int flags,
> +				   struct gc_arena *gc)
>  {
>    struct buffer out =3D alloc_buf_gc (128, gc);
>    bool addr_is_defined;
> +  char buf[NI_MAXHOST] =3D "";
> +
>    addr_is_defined =3D addr_defined (addr);
>    if (!addr_is_defined) {
>      return "[undef]";
>    }
> +
> +  int port;
> +  int salen;
>    switch(addr->addr.sa.sa_family)
>      {
>      case AF_INET:
> -	{
> -	  const int port=3D ntohs (addr->addr.in4.sin_port);
> -	  buf_puts (&out, "[AF_INET]");
> -
> -	  if (!(flags & PS_DONT_SHOW_ADDR))
> -	    buf_printf (&out, "%s", (addr_defined (addr) ? inet_ntoa (addr->add=
r.in4.sin_addr) : "[undef]"));
> -
> -	  if (((flags & PS_SHOW_PORT) || (addr_defined (addr) && (flags & PS_SH=
OW_PORT_IF_DEFINED)))
> -	      && port)
> -	    {
> -	      if (separator)
> -		buf_printf (&out, "%s", separator);
> -
> -	      buf_printf (&out, "%d", port);
> -	    }
> -	}
> +      port=3D ntohs (addr->addr.in4.sin_port);
> +      buf_puts (&out, "[AF_INET]");
> +      salen =3D sizeof (struct sockaddr_in);
>        break;
>      case AF_INET6:
> -	{
> -	  const int port=3D ntohs (addr->addr.in6.sin6_port);
> -	  char buf[INET6_ADDRSTRLEN] =3D "";
> -	  buf_puts (&out, "[AF_INET6]");
> -	  if (addr_is_defined)
> -	    {
> -	      getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
> -			  buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);
> -	      buf_puts (&out, buf);
> -	    }
> -	  if (((flags & PS_SHOW_PORT) || (addr_is_defined && (flags & PS_SHOW_P=
ORT_IF_DEFINED)))
> -	      && port)
> -	    {
> -	      if (separator)
> -		buf_puts (&out, separator);
> -
> -	      buf_printf (&out, "%d", port);
> -	    }
> -	}
> +      port=3D ntohs (addr->addr.in6.sin6_port);
> +      buf_puts (&out, "[AF_INET6]");
> +      salen =3D sizeof (struct sockaddr_in6);
>        break;
>      default:
>        ASSERT(0);
>      }
> +=09
> +  if (!(flags & PS_DONT_SHOW_ADDR))
> +    {
> +      getnameinfo(&addr->addr.sa, salen,
> +                  buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);
> +      buf_puts (&out, buf);
> +    }
> +  if (((flags & PS_SHOW_PORT) || (addr_is_defined && (flags & PS_SHOW_PO=
RT_IF_DEFINED)))
> +      && port)
> +    {
> +      if (separator)
> +        buf_puts (&out, separator);
> +=09=09
> +      buf_printf (&out, "%d", port);
> +    }
> +=09
>    return BSTR (&out);
>  }
>=20=20
> --=20
> 1.7.9.6 (Apple Git-31.1)
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
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

--8HhMLSHvAouSipEr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUERc06kuBuNlUUl1AQJrUAP/bfgTsT801UxcNLB66qrSeRPybTSoXGUg
IfzlTt4VIvVLUONovueD0UfsE8+w9cY+I24cdDJorfS6tmUk3dkK6zt4rrIRRFU4
y5pQN2faJjFOL3v/RqT2FoRV6uq8VIZC9Q2JKMVifAVy7AIdyrklwXaRHKJ6abcO
GkSMcy74GpI=
=aeur
-----END PGP SIGNATURE-----

--8HhMLSHvAouSipEr--

