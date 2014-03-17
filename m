Date: Mon, 17 Mar 2014 21:29:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140317202910.GM16637@...1296...>
References: <1395017376-24554-1-git-send-email-james@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkLAuYHWPDRvIaAS"
Content-Disposition: inline
In-Reply-To: <1395017376-24554-1-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
	context for OpenSSL builds,
	to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--jkLAuYHWPDRvIaAS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 16, 2014 at 06:49:36PM -0600, James Yonan wrote:
> However, even with the above code, stateless session resumption
> is still possible unless explicitly disabled with the
> SSL_OP_NO_TICKET flag.  This patch does this.

This actually raises an interesting question.  My OpenSolaris buildslave
fails compilation with

gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../src/compat -g -O2 =
-MT ssl_openssl.o -MD -MP -MF .deps/ssl_openssl.Tpo -c -o ssl_openssl.o ssl=
_openssl.c
ssl_openssl.c: In function `tls_ctx_set_options':=20=20
ssl_openssl.c:183: error: `SSL_OP_NO_TICKET' undeclared (first use in this =
function)

... while "configure" doesn't flag an error about the OpenSSL version
installed (0.9.8a-fips).  This is not ideal, if we know we're going to=20
fail at compile time due to missing functionality, we should tell the
user earlier.

Right now, if I read configure.ac correct, we require 0.9.6 or later (and
check this only if pkg-config is available) - but obviously, SSL_OP_NO_TICK=
ET=20
was added later on.

Fix 1: only use SSL_OP_NO_TICKET if available
Fix 2: require a more recent OpenSSL version

Crypto guys, send me patches :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jkLAuYHWPDRvIaAS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUydbFqkuBuNlUUl1AQK+mAQAoa5RwbcUoIff8Cd8mcMAyiS9P3wNYmYv
8CbvBdorkr0jbPLTt+VmWFqLZfberM0KJkn8dD3oDsqYs1BrAiV2IhmBKRR0gkyc
/OQa9BTP4Yf1hgUcecFru6eHXJK/GWqih2IGUxa1M4IqXzkB8O7n7uYpuJhkJ6mW
Y0yL9ds/f2g=
=pjED
-----END PGP SIGNATURE-----

--jkLAuYHWPDRvIaAS--

