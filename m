Date: Thu, 20 Jun 2013 20:02:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130620180244.GV20843@...1296...>
References: <1370605779-712-1-git-send-email-dazo@...384...>
	<1371032316-18281-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXXtuus8Blsk4XO4"
Content-Disposition: inline
In-Reply-To: <1371032316-18281-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH v2] plugin: Extend the plug-in v3 API to
	identify the SSL implementation used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--LXXtuus8Blsk4XO4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 12, 2013 at 12:18:36PM +0200, David Sommerseth wrote:
>  v2 - add const ovpnSSLAPI ssl_api at the end of
>       struct openvpn_plugin_args_open_in and not in the "middle"

NAK, because:

> @@ -372,6 +372,7 @@ plugin_open_item (struct plugin *p,
>         */
>        if (p->open3) {
>          struct openvpn_plugin_args_open_in args =3D { p->plugin_type_mas=
k,
> +                                                    SSLAPI,
>                                                      (const char ** const=
) o->argv,
>                                                      (const char ** const=
) envp,
>                                                      &callbacks };

... it's still sitting in the middle in the init function...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LXXtuus8Blsk4XO4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcNDxKkuBuNlUUl1AQI/6AP/Y8Iutq19gfP1QXmzuOx/C3xLlnNXuprE
uI/aF6ZEGjwtVmla8UTgP/Zw4vkCQxcLOmZEADnG9jB5VP9ioXPWyCh2BizA5WJt
M1vHfAeSM9o2pHhq+oEOLE1UZ4vATwMvMuvRH4do3nOXQ7PdVPrezZtIvorJgOkI
e1g2zuOai4s=
=65Ii
-----END PGP SIGNATURE-----

--LXXtuus8Blsk4XO4--

