Date: Thu, 14 Jul 2011 09:17:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110714071744.GZ8496@...1296...>
References: <1310602349-22195-1-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eQVb8LtVuZ3Ce2vx"
Content-Disposition: inline
In-Reply-To: <1310602349-22195-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] Final Visual studio compile fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

--eQVb8LtVuZ3Ce2vx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 13, 2011 at 05:12:27PM -0700, samuli@...515... wrote:
> These two patches fix two remaining Visual Studio compile issues. When th=
ese are=20
> applied on top of the existing patches in tmp/winbuildfix (openvpn-testin=
g.git=20
> repo), Visual Studio builds finally work.

ACK!

(First one is an oversight - GNU C accepts variable declarations in the
middle of a block, MS VC not - and the second is just a typo)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--eQVb8LtVuZ3Ce2vx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTh6YGKkuBuNlUUl1AQIvUwQAwqZ5h6EacW+pcV2Iq+Ac8QrWj9EVJqdt
fmil08eerhuV6ThJhJTAnPCUYfZwZqmzzR+hX4RV2sYcgUcA1VhGzGPGVXiOYkod
S3f4WuG3Y3fWPAwrxMETd6hi3ZpH9kvx5OGtSjE+9hTtvIuD601R9Fkbxy56YkgY
XUT2VUqXGmw=
=cH2K
-----END PGP SIGNATURE-----

--eQVb8LtVuZ3Ce2vx--

