Date: Mon, 23 Nov 2015 20:23:59 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151123192359.GR24952@...1296...>
References: <1448304969-2277-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hn090KliNom6wizA"
Content-Disposition: inline
In-Reply-To: <1448304969-2277-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in add_option() by
 simplifying get_ipv6_addr
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

--hn090KliNom6wizA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 23, 2015 at 07:56:09PM +0100, Steffan Karger wrote:
> If get_ipv6_addr() would fail *after* allocating memory for ipv6_local,
> add_option() would fail to free that memory.
>=20
> The fix here is to remove the allocation from get_ipv6_addr(), and create
> a separate function for the strip-and-allocate, such that failures are
> easier to handle.

Generally speaking, this makes sense.  This particular bit is unsafe (so NA=
K):

> @@ -4467,10 +4481,9 @@ add_option (struct options *options,
>    else if (streq (p[0], "ifconfig-ipv6") && p[1] && p[2] )
>      {
>        unsigned int netbits;
> -      char * ipv6_local;
>=20=20
>        VERIFY_PERMISSION (OPT_P_UP);
> -      if ( get_ipv6_addr( p[1], NULL, &netbits, &ipv6_local, msglevel ) =
&&
> +      if ( get_ipv6_addr( p[1], NULL, &netbits, msglevel ) &&
>             ipv6_addr_safe( p[2] ) )
>          {
>  	  if ( netbits < 64 || netbits > 124 )
> @@ -4483,7 +4496,7 @@ add_option (struct options *options,
>              /* explicitly ignoring this is a const char */
>              free ((char *) options->ifconfig_ipv6_local);
>=20=20
> -	  options->ifconfig_ipv6_local =3D ipv6_local;
> +	  options->ifconfig_ipv6_local =3D get_ipv6_addr_no_netbits (p[1], &opt=
ions->gc);

There's a free() in case this option is called twice - but since the
address is in &gc now, we must not free() it...

(Seems when I wrote that, I did not grok the options->gc possibilities yet)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hn090KliNom6wizA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlNnyKkuBuNlUUl1AQKDeQP/bQax2Qt2a3ITjnwlbuCeUJ1DXnXZU7Fa
xpXAkS8Qn6AKSbdUDuc9b4fZsgSerd/Xm780s0OlBb71ljUJ7as+Ov0TAkuaRs+2
r7XJVeJz3LPFLTPfBEvC5NaMsdYUNj1coBQxgL2IAQQcPFnjB9/EIb+LnvjKvtB8
U1uDS7+wPSw=
=3BTk
-----END PGP SIGNATURE-----

--hn090KliNom6wizA--

