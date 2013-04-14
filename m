Date: Sun, 14 Apr 2013 12:07:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130414100733.GL569@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QVzQgM+zdZ3YWXqn"
Content-Disposition: inline
Subject: [Openvpn-devel] stray USE_SSL in crypto_openssl.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--QVzQgM+zdZ3YWXqn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this is something for Adriaan or Steffan, I think...  in crypto_openssl.c,
we have two stray uses of #ifdef USE_SSL...

void
crypto_init_lib (void)
{
#ifndef USE_SSL
#ifndef ENABLE_SMALL
  ERR_load_crypto_strings ();
#endif
  OpenSSL_add_all_algorithms ();
#endif

...
void
crypto_uninit_lib (void)
{
#ifndef USE_SSL
  EVP_cleanup ();
#ifndef ENABLE_SMALL
  ERR_free_strings ();
#endif
#endif


... should this be ENABLE_SSL?  Or not be there at all?

I won't claim to understand the code, but I can say for sure that we
do not have a "USE_SSL" conditional anymore :-) - this is now ENABLE_SSL.

Please check and send patch :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QVzQgM+zdZ3YWXqn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWp/5akuBuNlUUl1AQLjlQP/RW4MfgdTvINDnWGo3x21o10/UsBjX2oZ
GtK3/aUUIn8Hr6Zs7e2tjxz7LDUUysznJSKjBDrnKamTOdu/IJBQAp2wpNTGfngi
9nK2RbT2xHXXt5K9OsBHfdyNsl6s5p7xdM+tNE2cZjxxWpcSAtG6z+pNEzPApbpo
zs4RZ71IMA8=
=yDDB
-----END PGP SIGNATURE-----

--QVzQgM+zdZ3YWXqn--

