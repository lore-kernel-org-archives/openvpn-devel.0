Date: Fri, 8 Jan 2016 08:41:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160108074124.GR24952@...1296...>
References: <71715370-6FF1-41BC-94FA-12EBE8E33A40@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EnKxfBJhHVAs8tak"
Content-Disposition: inline
In-Reply-To: <71715370-6FF1-41BC-94FA-12EBE8E33A40@...277...>
Subject: Re: [Openvpn-devel] Code to confirm "FIPS MODE" throwing compile
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kevin Long <kevinlong206@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--EnKxfBJhHVAs8tak
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Thu, Jan 07, 2016 at 02:57:34PM -0800, Kevin Long wrote:
>=20
> I believe I have successfully compiled openvpn on debian , using static o=
penssl library containing the FIPS compliance module.
>=20
>=20
> However, I have followed this instruction found online:
>=20
> "Now you should have a FIPS capable OpenSSL (NOTE: OpenSSL itself is not =
FIPS validated, only FIPS capable along with the FIPS Object Module). To ma=
ke OpenVPN FIPS compliant, you need to add:
>=20
> #ifdef OPENSSL_FIPS=20
>         if(options.no_fips <=3D 0) {
>                 if(!FIPS_mode_set(1) {
>                         ERR_load_crypto_strings();
>                         ERR_print_errors_fp(stderr);
>                         exit(1);
>=20
>                }
>        }
>        else
>                fprintf(stderr,"*** IN FIPS MODE ***\n");
> #endif

I'm not sure where this is coming from (it's not something I've seen
before) but it is at least broken C code - the "if (!FIPS_mode_set(1)" line
is missing a closing bracket - and it is based on patches to options.c
and options.h that are missing - as you've noticed, there is no "no_fips"
field in the "options" structure (and, at this place in the code, there
is not even an "options" variable around).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EnKxfBJhHVAs8tak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVo9oI6kuBuNlUUl1AQIWqgP9Hu4iJu3nsP+m4vl11l+oax1pORcY7Jd4
R8v03fB0Rm2P1BLsRHr5/zR+i1sMiwObQnCMuIP/T511T3AlEO6/yjrFu7GpjBgc
cyUqxxhI348s8Zo6AwcEZ6FVO9PRZjyiLg+UsG8xjtufbLG7q4lts7eW1Ry7VCDf
vXn3zhoVb/Q=
=K3sL
-----END PGP SIGNATURE-----

--EnKxfBJhHVAs8tak--

