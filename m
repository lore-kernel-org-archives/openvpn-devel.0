Date: Tue, 19 Mar 2013 15:26:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130319142655.GX953@...1296...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L3OKINy5etNmFu3S"
Content-Disposition: inline
In-Reply-To: <1363624652-7001-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
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

--L3OKINy5etNmFu3S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 18, 2013 at 05:37:28PM +0100, steffan.karger@...1435... wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> Add support for PolarSSL-1.2, which has changed the API in several places.
> This is a minimal port, new features have not been enabled. Only PolarSSL
> 1.2.5 and newer are accepted, as earlier versions contain unresolved
> (security) issues.

NAK, actually, for two reasons:=20=20

 - there is "something wrong" with the blowfish support - patching=20
   release/2.3 in git with these 5 patches and compiling with polar 1.2.5
   creates a binary that is not interoperating with openssl-compiled
   openvpn (cipher blowfish-cbc on the polar side, bf-cbc on openssl) - it=
=20
   negotiates just fine, but data packets cannot be decrypted

14:23 <@dazo> Tue Mar 19 14:16:08 2013 Authenticate/Decrypt packet error:=20
              cipher final failed

 - when configuring with --enable-pkcs11, compilation fails

14:17 <@dazo> ssl_polarssl.h:69:5: error: expected specifier-qualifier-list=
=20
              before \u2018pkcs11_context\u2019

(I'm just relaying, David did the actual testing... my buildbot box is still
busy trying to compile polar 1.2.6...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--L3OKINy5etNmFu3S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUUh1r6kuBuNlUUl1AQL4VAQAj3tHH3Tfk2W6SrlE0GllQi1+XnUjQdQd
17rnxF6G+knu+yCeafwyEKnRKXzffDWLokaoZulNESOybQGSPOlraszuBZOdBhDc
xysKYVE4CFCrVdWkA4hcUvAsNwRZV/OL9Gc6KpP6ACMx5ZykdLM/o4qkjLeSI+NC
YR2SQkkLBdk=
=CYIk
-----END PGP SIGNATURE-----

--L3OKINy5etNmFu3S--

