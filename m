Date: Tue, 15 Dec 2015 08:53:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151215075312.GN24952@...1296...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QusHdSTmowIXBQA5"
Content-Disposition: inline
In-Reply-To: <566F5B01.8020109@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--QusHdSTmowIXBQA5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 01:12:49AM +0100, David Sommerseth wrote:
> Just tried to build openvpn on one of my laptops (Scientific Linux 7.1,
> openssl-1.0.1e-42.el7).  And it explodes when reaching the
> SSL_CTX_get0_certificate(), it seems that support arrived in OpenSSL 1.0.=
2?
> Could that be right?  Haven't had brainpower yet to dig deeper.

Yeah, we noticed.  Sorry for that.  Never seen so much red on the buildbot
list before... :-)

Committed and pushed the "not before 1.0.2" workaround.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QusHdSTmowIXBQA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVm/G56kuBuNlUUl1AQLNjwP+Npr1L/WCBBO618Ozd4hBm8t+He6XJfMz
vhVySFqTsn3u4U/h0P5XJlNBDKNmBVD1pJDemwvOm+eFXXmDpeMj7xPB7uYQwIcG
U/e64Q6xVGu8pTsLG2oPIkRaDHy5xIIuJiWKrwbePp0sIgaztI1E5lrUVJ6xF1Nq
T46k27ZpsiQ=
=jV+B
-----END PGP SIGNATURE-----

--QusHdSTmowIXBQA5--

