Date: Sun, 28 Apr 2013 13:32:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130428113214.GO20843@...1296...>
References: <1367006045-13576-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <1367006045-13576-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [[Patch v3] 1/3] Allow routes to be set before
	opening tun, similar to ifconfig before opening tun
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

--P+33d92oIH25kiaB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 26, 2013 at 09:54:03PM +0200, Arne Schwabe wrote:
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 979ba23..f08583b 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
[..]
> -      if (!c->options.route_delay_defined)
> +      if ((ifconfig_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.rout=
e_delay_defined))

uh...?  ifconfig_order() again?

> -	  if (c->options.route_delay_defined)
> +	  if ((ifconfig_order() =3D=3D ROUTE_AFTER_TUN) && c->options.route_del=
ay_defined)

And here.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUX0IvqkuBuNlUUl1AQK/CgQAjymjo2GSCeWACCxY++Znuy012N13ejX1
dl/j/PYhGrc744t15ozoxlKBU2NeMIj10fXrCZ6/G9pUB5bal+jymIKkp/1FqCt8
qe+wcZy+r3pUrj/PNENcY/OUW090fRpgeHSmgrOxqNIkUBeMP4OtDjBzNklFa361
sXNM96GFjLE=
=PTQG
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--

