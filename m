Date: Mon, 17 Mar 2014 09:33:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140317083335.GB16637@...1296...>
References: <1395017376-24554-1-git-send-email-james@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q2KDfiZqTI2kUwWN"
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

--q2KDfiZqTI2kUwWN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 16, 2014 at 06:49:36PM -0600, James Yonan wrote:
> OpenVPN doesn't want or need SSL session renegotiation or
> resumption, as it handles renegotiation on its own.
>=20
> For this reason, OpenVPN always disables the SSL session cache:
>=20
> SSL_CTX_set_session_cache_mode (ctx, SSL_SESS_CACHE_OFF)
>=20
> However, even with the above code, stateless session resumption
> is still possible unless explicitly disabled with the
> SSL_OP_NO_TICKET flag.  This patch does this.

I assume this should go into all OpenVPN branches, that is, master, 2.3, and
if we ever do another 2.2, into that one as well?

(not ACKing or NAKing the patch itself, this is not my field of expertise)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--q2KDfiZqTI2kUwWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUyazX6kuBuNlUUl1AQJSxQP9GLfowTl16HeDm6HgzRf7GkjpqOiu4Bg2
OnmT8/qg3QYigC1zZqxmTiioYAjkjiYMEEHtik3QC7JfB/Ni6vapp78ZT6ps4gVn
KFPgBI7PCjZpVrYgiAoftjGC3wMi4aiua3ZnF78hvVEbrQTTuXbP/zEhJfLBAq70
q7Lg92NL5IQ=
=XUDs
-----END PGP SIGNATURE-----

--q2KDfiZqTI2kUwWN--

