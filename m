Date: Tue, 26 Jun 2012 16:09:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120626140915.GU22125@...1296...>
References: <CAOazyz3e6j+t5BPqpUa6iTErsVzm9Nof4EtP+atx9vvBKNsobw@...278...>
	<1340719406-12157-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Content-Disposition: inline
In-Reply-To: <1340719406-12157-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set defaults using a
	complex logic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 26, 2012 at 05:03:26PM +0300, Alon Bar-Lev wrote:
> pam cannot be compiled on OpenBSD and Windows.
> down-root cannot be compiled on Windows.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index db19d4a..d3d974d 100644

Thanks, this looks good to me.  (Yes, it's complex, but since my much=20
simpler proposal of "if you can't find libpam, don't build the plugin"=20
is unacceptable to you, this is how it will have to be)

ACK for OpenBSD, but Samuli, please test for Windows.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+nCi6kuBuNlUUl1AQKEEAQAgAFkfxaJWj0M9Wyohm/6kDnVZi5jX2BK
170RHOq2Y5HYpfxtvk2Q5hXLv0Qpdj7jI5G4oxAH218x7Y2iGTS9gYo4Sp/db18J
Eif/b5wb4s3TtCv0T+PpRPtlE1nmqqgEes2Zh+W71TiudRfPL+95A3vTAMDk24f9
Ea6NYT3itIE=
=IVKw
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--

