Date: Tue, 11 Jul 2017 12:41:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170711104135.GL97029@...1296...>
References: <20170710043441.24770-1-a@...2181...>
	<20170710043441.24770-3-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qPKv0B48MkL7YSxy"
Content-Disposition: inline
In-Reply-To: <20170710043441.24770-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] ntlm: avoid useless cast
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--qPKv0B48MkL7YSxy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 10, 2017 at 12:34:39PM +0800, Antonio Quartulli wrote:
>          /* NTLMv2 hash */
> -        my_strupr((unsigned char *)strcpy(userdomain, username));
> +        my_strupr(strcpy(userdomain, username));

While at it, could you change that eyesore to

           strcpy(userdomain, username);
           my_strupr(userdomain);

as well...?

I find this sort of chaining of function calls tremendously hard to read.

(... in a ntlm.c cleanup 5/4 patch :))

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qPKv0B48MkL7YSxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZZKteAAoJEB2Cnv7KVigScsAL/290dRszeKTdryIUbXiJJvTt
ecHgo5+vC2TG6Rnp0MYxFXmMFNDWYlIKU5cANpH9b3M64iFfi8nt+Lh72zq5lTAX
PwY/I83buPiqDVlrOsJ1qKlrLiKigyhbUMw3BOiNB+F9QxYoUQoEDbuoJ5ub4Y5x
rVtuiDpxUgbk91RcQwMjL4z8nacnkXwBfDXlNIpEus8USvJ+NH4HqgnQdhKco1MK
t3D4fJirnfpcxmZj5fs7i7QkutltU5PCqT+gVLHP5T8evPGTFzj/eLiXixNGbrVg
kwKjp8+u6CnMGVhAnkLiptLTQn542dgVImd8FaBEygrIJm6jj+nkBT+R4Gd6tPaM
Nwwfd73lxu0HKO8i2QlHSCcIRBBkQjC585iL4oCv+M/BQuWxdCw6SgilhwFsSKHG
Cskgqem1JSpwMvqtiSQVEdRZZWcUW6eaJ6HdH177BX7bdmDD/9BpeO1eH447zyOs
e292FW6cl0D+4uwA1JMLfDxxJjlokSbChsZ4UdhN4w==
=GfqV
-----END PGP SIGNATURE-----

--qPKv0B48MkL7YSxy--

