Date: Sat, 12 Jul 2014 11:41:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140712094130.GM1118@...1296...>
References: <53BF9998.5020906@...1921...> <53BFAF81.2080705@...1147...>
	<53BFC22C.5010601@...1227...> <53BFF9BE.1090204@...1147...>
	<20140711180758.GJ1118@...1296...>
	<53C02A4E.6040103@...1147...> <53C02E63.9070909@...1856...>
	<53C07082.8060906@...1147...>
	<306985396.19324.1405156126494.JavaMail.zimbra@...1795...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pjXrr8OcmD/XY8aP"
Content-Disposition: inline
In-Reply-To: <306985396.19324.1405156126494.JavaMail.zimbra@...1795...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
	configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--pjXrr8OcmD/XY8aP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 12, 2014 at 11:08:46AM +0200, David Sommerseth wrote:
> > my question would be : why does openvpn need SSL_OP_NO_TICKET? why not
> > #ifdef the code, e.g.
> >=20
> >    SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3
> >    #ifdef SSL_OP_NO_TICKET
> >       | SSL_OP_NO_TICKET
> >    #endif
> >    );
> >=20
> > (this is non-openvpn code) ?
>=20
> I agree, this seems to be the best approach.  I suspect the issues relate=
d to=20
> SSL_OP_NO_TICKET has been resolved by Red Hat on EL5, but the fix may not=
 have
> provided that flag.

This is what we do in 2.3.  For 2.4 we decided (on the list, btw!) to=20
require that this is there, instead of silently hoping that the SSL library
would get it right (which it does not, according to James).  See=20
25f4d4b49bff342fd9dd54cd and e9b088b208479.

commit 25f4d4b49bff342fd9dd54cd22f14c9de49e9f8b
Author: James Yonan <james@...515...>
Date:   Sun Mar 16 18:49:36 2014 -0600

    Set SSL_OP_NO_TICKET flag in SSL context for OpenSSL builds, to disable=
 TLS stateless session resumption.
=20=20=20=20
    OpenVPN doesn't want or need SSL session renegotiation or
    resumption, as it handles renegotiation on its own.
=20=20=20=20
    For this reason, OpenVPN always disables the SSL session cache:
=20=20=20=20
    SSL_CTX_set_session_cache_mode (ctx, SSL_SESS_CACHE_OFF)
=20=20=20=20
    However, even with the above code, stateless session resumption
    is still possible unless explicitly disabled with the
    SSL_OP_NO_TICKET flag.  This patch does this.


> In addition, EL5 is the oldest distro we support (after we convinced Jame=
s to
> ditch EL4 when that went officially EOL; not counting the extended support
> some few customers may pay for).

Any way to convince RH to pick up this security-relevant fix?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pjXrr8OcmD/XY8aP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU8ECyqkuBuNlUUl1AQJKxgP+NayihEpIgJ08jOvkKn0NX1KhDfWMowZF
ZjXzP3jVieVnOl4pQaAHOmvNiG4HOXksScV6EeqKEc7KEyIZc9Kh95e4hYqxZ36z
f4QNY0FZDIQSJXY9+Lh/44w1L+QCVKOQBVAcxdjKKAsRCfjkgX8KkiNozngbepcd
IquXcysZ9Ds=
=9PFV
-----END PGP SIGNATURE-----

--pjXrr8OcmD/XY8aP--

