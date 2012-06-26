Date: Tue, 26 Jun 2012 15:35:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120626133532.GK22125@...1296...>
References: <1340715726-14670-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <1340715726-14670-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set default to no in
	Windows
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

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 26, 2012 at 04:02:06PM +0300, Alon Bar-Lev wrote:
> Both plugins cannot be compiled on Windows anyway.

Can you auto-disable plugin-auth-pam for OpenBSD as well, please?=20=20

We ran into this on the OpenBSD buildslave today - OpenBSD has no PAM
whatsoever, so it would be nice to not have to care.

(Leaving the ACK on the windows patch to Samuli - looks good to me, but
I can't test right now)

thanks.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+m6pKkuBuNlUUl1AQJ7XwP+PBElXoTuRbSeBAfHkdpK1yurL9v0pjEU
jmm6FMHyVaksq0ct+MtOyiLSL9Uku5v5kzO1joWUlMu0CMKDmXuS+zJ5IycXBatr
q8mXnh2LZl9uEzUMd7lNditG1vToBmNLMjIWghwr/OlS1rPXOyAnWQn5ukE67OV8
CCNCTlQCKHE=
=7w9d
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

