Date: Wed, 11 Nov 2015 20:40:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151111194006.GB24952@...1296...>
References: <20151111081604.GU24952@...1296...>
	<1447242487-30243-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BfbbJsf3thGkpLcA"
Content-Disposition: inline
In-Reply-To: <1447242487-30243-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Olli Mannisto <olmannisto@...277...>, openvpn-devel@lists.sourceforge.net

--BfbbJsf3thGkpLcA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 11, 2015 at 01:48:07PM +0200, Lev Stipakov wrote:
> @@ -1301,18 +1303,20 @@ do_ifconfig (struct tuntap *tt,
>      if ( do_ipv6 )
>        {
>  	char * saved_actual;
> +	char iface[64];
>=20=20
>  	if (!strcmp (actual, "NULL"))
>  	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than on=
e TAP-Windows adapter, you must also specify --dev-node");
>=20=20
> -	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d sto=
re=3Dactive */
> +	openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu", get_adapter_i=
ndex_flexible(actual));

Uh.  I'm afraid if I speak up once more, you'll stop talking to me...
(or not give me any beer next time we meet :) )

> +	/* example: netsh interface ipv6 set address interface=3D42 2001:608:80=
03::d store=3Dactive */
>  	argv_printf (&argv,
> -		    "%s%sc interface ipv6 set address %s %s store=3Dactive",
> +		     "%s%sc interface ipv6 set address %s %s store=3Dactive",
>  		     get_win_sys_path(),
>  		     NETSH_PATH_SUFFIX,
> -		     actual,
> -		     ifconfig_ipv6_local );
> -

... but wouldn't

  	argv_printf (&argv,
		    "%s%sc interface ipv6 set address interface=3D%lu %s store=3Dactive",
  		     get_win_sys_path(),
  		     NETSH_PATH_SUFFIX,
		     get_adapter_index_flexible(actual),
		     ifconfig_ipv6_local);

(without storing into a temp variable) work "just fine"?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BfbbJsf3thGkpLcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkOZlakuBuNlUUl1AQKpkQP/dsjPxOLVgQ7NQpXb0CVSp5tkcKINmlZl
a8Gh/xhtRuGyP692Njmj7BkYlR5JN4OezQfrfyOndwR0jcqEP5LRXg6oz0pa2bLs
gfuIUwSG2Xc8N9ngIfBbrfT/tpkD2+ZH3S7bG0/q71a13YPm6iVH6nnoDDTrktIo
mlLSXValWmI=
=aXa0
-----END PGP SIGNATURE-----

--BfbbJsf3thGkpLcA--

