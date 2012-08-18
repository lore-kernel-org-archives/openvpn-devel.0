Date: Sat, 18 Aug 2012 11:47:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120818094734.GU18296@...1296...>
References: <1345197136-24708-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <1345197136-24708-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] remove stale _openssl_get_subject()
	prototype
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 17, 2012 at 11:52:16AM +0200, Heiko Hund wrote:
> The _openssl_get_subject() function was removed in commit
> 00b973f8af85c3ea8fa3cef80eec55e8dc139b27. The functionality
> moved to x509_get_subject().

ACK.  Pure leftover in ssl_verify_openssl.h, not referenced from anywhere.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUC9ktqkuBuNlUUl1AQJVLwP+O84fqD6lP1eQHzbng2bIMc0W0PqZg4to
yKHpxgs/XGU7BFaCM6/AdPGtd/DY9b10SQV8FicIZuzawQ3SJLkuNDz9YJXCGQuv
XiloE3neOiEIrr+JOeZRJvrE8SNblxmnUKmlkmRCgDZsql0fngCsxXshdctj8vMa
c6mFiZQahzI=
=elOC
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

