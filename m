Date: Fri, 6 Nov 2015 21:56:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151106205635.GA24952@...1296...>
References: <1446761780-13816-1-git-send-email-steffan@...1856...>
	<1446795759-3288-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dwWFXG4JqVa0wfCP"
Content-Disposition: inline
In-Reply-To: <1446795759-3288-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH (master,
 v2)] Fix (potential) memory leak in init_route_list()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 06, 2015 at 08:42:39AM +0100, Steffan Karger wrote:
> init_route() can allocate memory in netlist, but fail in many more ways
> than just fail to allocate.  Thus, always check and clean up netlist if
> needed, instead of just when init_route() succeeds.
>=20
> This fix is for master only.  The release/2.3 branch cleans up netlist
> immediately, and needs a different patch for a similar problem.
>=20
> Found using coverity.
>=20
> v2: initialize netlist to NULL

I'm fine with the patch as is (so "ACK"), but I'm wondering about
something.

> @@ -642,7 +642,6 @@ init_route_list (struct route_list *rl,
>  	else
>  	  {
>              struct addrinfo* curele;
> -            gc_addspecial(netlist, &gc_freeaddrinfo_callback, &gc);
>              for (curele	=3D netlist; curele; curele =3D curele->ai_next)
>  	      {
>                  struct route_ipv4 *new;
> @@ -653,6 +652,8 @@ init_route_list (struct route_list *rl,
>                  rl->routes =3D new;
>  	      }
>  	  }
> +	if (netlist)
> +	  gc_addspecial(netlist, &gc_freeaddrinfo_callback, &gc);
>        }
>    }

I can see why we do this gc_addspecial() dance in socket.c (because the
elements returned by getaddrinfo() are being pointed at, not copied).

This usage here seems unneeded, as the code will walk netlist, copy
out the IPv4 addresses into a separate (gc-allocated) struct route_ipv4,
and never use parts of netlist again - so freeaddrinfo() *should* work,
and make the code slightly less complex.

Arne, this came from you in commit e719a053534 (and I ACKed it) - could
you revisit this particular use and check whether it's truly needed?

thanks,

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dwWFXG4JqVa0wfCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVj0UAqkuBuNlUUl1AQKcrQQAnV4jJ75AWqsx50+pBY7SEZTHlSCEM6Gb
dqBIreDZcclgxm8zypj3BCjhnavkD29MYSQGjZtzcPGthYLvbXaHNVolU5Dd5WVm
eXE/ybioh5ofz7bZsfhFivlPkRmFkXnTHXP63p1tTCSFZMdfK/8tp5kMkGUxWY7f
UzSDSVyxvbU=
=a/5F
-----END PGP SIGNATURE-----

--dwWFXG4JqVa0wfCP--

