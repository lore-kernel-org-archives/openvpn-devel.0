Date: Sat, 14 May 2011 14:03:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110514120304.GO8496@...1296...>
References: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsSkVHHhotaZRe1D"
Content-Disposition: inline
In-Reply-To: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
	interface disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Matthew L. Creech" <mlcreech@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--KsSkVHHhotaZRe1D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 11, 2011 at 05:57:28PM -0400, Matthew L. Creech wrote:
> I just upgraded to 2.2.0, and my build fails with:
>=20
> ps.c: In function 'port_share_open':
> ps.c:778:7: error: 'management' undeclared (first use in this function)
> ps.c:778:7: note: each undeclared identifier is reported only once for
> each function it appears in
> make[5]: *** [ps.o] Error 1

Thanks for reporting it.  As far as I can see, this problem came in via
c7dd80cf45efa (aka 2.1.3s), and that is obviously only needed if management
is enabled.

So: ACK from me.

Samuli: we need buildbot variants with/without management, it seems...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KsSkVHHhotaZRe1D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTc5veKkuBuNlUUl1AQLSHwP+O7pSUqjylrSbRo4iaelKttjODWZu8lfM
dkNik+6xcVFwCrFsY2ze5C6xh3X2Vs0UyQZ4cmA5+zkrB4cbQQJBU7wsPri07srS
HkjXY+W8sxofwGHSZnM/RbXBw3lDw580VfU9Hls8M7E7gLmdUdM9+Pq2eWKsLx0r
vind3u5wyD4=
=g5IB
-----END PGP SIGNATURE-----

--KsSkVHHhotaZRe1D--

