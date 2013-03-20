Date: Wed, 20 Mar 2013 09:52:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130320085250.GA953@...1296...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-5-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1QBrjqN6h9gZEy9v"
Content-Disposition: inline
In-Reply-To: <1363624652-7001-5-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added
	translate_cipher_name.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

--1QBrjqN6h9gZEy9v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 18, 2013 at 05:37:31PM +0100, steffan.karger@...1435... wrote:
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6223,7 +6223,7 @@ add_option (struct options *options,
>      {
>        VERIFY_PERMISSION (OPT_P_CRYPTO);
>        options->ciphername_defined =3D true;
> -      options->ciphername =3D p[1];
> +      options->ciphername =3D translate_cipher_name(p[1]);
>        if (streq (options->ciphername, "none"))
>  	{
>  	  options->ciphername_defined =3D false;

Uh.  NAK, unfortunately, because while this should work for the actual
cipher translation, it fails OCC...

Tue Mar 19 15:45:01 2013 WARNING: 'cipher' is used inconsistently, local=3D=
'cipher BLOWFISH-CBC', remote=3D'cipher BF-CBC'

... incidentially, OCC also gives a hint why the interop test failed...

Tue Mar 19 15:45:01 2013 WARNING: 'keysize' is used inconsistently, local=
=3D'keysize 32', remote=3D'keysize 128'
Tue Mar 19 15:45:01 2013 Data Channel Encrypt: Cipher 'BLOWFISH-CBC' initia=
lized with 32 bit key

"wut?"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1QBrjqN6h9gZEy9v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUUl44qkuBuNlUUl1AQL2ngP9G58xntKS4gYtJan4bIuMqvBj1/wDtATV
tI9rJBxOr4+eLUWJTE3LsxSQziU4jXXR9NH/MejPrnaA7ACuodS+UQvhF/IloEuf
NlXRHKVBf98uukuSMl7R37NbT431kIvh0N950E7cfNkgXS8xW3We5bpx0gTFsvV1
ZG1zeowcWFM=
=Kj3n
-----END PGP SIGNATURE-----

--1QBrjqN6h9gZEy9v--

