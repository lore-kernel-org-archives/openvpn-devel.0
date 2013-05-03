Date: Fri, 3 May 2013 11:58:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130503095831.GV20843@...1296...>
References: <klul5d$8ta$1@...1062...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <klul5d$8ta$1@...1062...>
Subject: Re: [Openvpn-devel] [PATCH] Fix proto tcp6 for server & non-P2MP
	modes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 02, 2013 at 04:17:37PM -0500, Josh Cepek wrote:
> This fix adds support for using tcp6 as a proto in server or non-P2MP
> modes, resolving a failed ASSERT in such cases.

ACK, thanks for the patch.  Will apply to master and 2.3 branch ASAP
(with the understanding that the master/2.4 branch will eventually get
Arne's dual-stack patches, which make this whole mess moot).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUYOKR6kuBuNlUUl1AQJRGAQAqJ3PZ7LTNl/stAGw+WvifMNK16XNkEC6
Z8ilFqW8Bqa8eltMhm/+qDsz7NVcukSlDgewso3T3FhKow4C1mzmT+3n/Ei1xKMI
28krfBtXxX29+vdUf90I8VCfvAFuV1TYrIeRW3wHu1E8TgaE+k8FUyMHwSzo6Yv7
Psqgvu6kr/4=
=Upr2
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

