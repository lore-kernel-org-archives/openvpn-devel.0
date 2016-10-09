Date: Sun, 9 Oct 2016 17:06:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161009150659.GP78279@...1296...>
References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gXLf3Z1A6KOgPzv4"
Content-Disposition: inline
In-Reply-To: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--gXLf3Z1A6KOgPzv4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2016 at 06:01:41PM +0200, Heiko Hund wrote:
> This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some
> initialization code to init_tun, where it belongs, and removes duplicate
> code that is now no longer needed.

Plus "it tries to make code look nicer and breaks it"...

> @@ -1366,25 +1366,6 @@ do_ifconfig (struct tuntap *tt,
>=20=20
>      if ( do_ipv6 )
>        {
> -	char * saved_actual;
> -	char iface[64];
> -	DWORD idx;
> -
> -	if (!strcmp (actual, "NULL"))
> -	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than on=
e TAP-Windows adapter, you must also specify --dev-node");
> -
> -	idx =3D get_adapter_index_flexible(actual);
> -	openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu", idx);
> -

The reason why "interface=3D%lu" is snprintf()'ed into "iface" is that...

> @@ -1393,17 +1374,16 @@ do_ifconfig (struct tuntap *tt,
>  	  {
>  	    /* example: netsh interface ipv6 set address interface=3D42 2001:60=
8:8003::d store=3Dactive */
>  	    argv_printf (&argv,
> -			 "%s%sc interface ipv6 set address %s %s store=3Dactive",
> +			 "%s%sc interface ipv6 set address interface=3D%lu %s store=3Dactive",

... argv_printf() does not understand "%lu", thus ignores it, finds "%s"
as the next argument, and blows up trying to string-copy "tt->adapter_index=
".

When doing massive changes, please do not "optimize" at the same time...


Running more tests with that hunk reverted next...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gXLf3Z1A6KOgPzv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/pdEqkuBuNlUUl1AQL45wP6A07pWAu6WDZGMH7o4G1X/rHhbvB4TbX+
D+RoV/e3xSUubjNaINKYYjhF7g6kJMEhlDzXFgY83/4CjS6LXmeKylENWQeC8xoN
LV8QiC1GqfdMU02kDf7oHdQDD6pJXhSr5pqoZ7HhDWv3rKEC4Sb4UiWTgCFskdTj
MofSBc8cQSg=
=eSI1
-----END PGP SIGNATURE-----

--gXLf3Z1A6KOgPzv4--

