Date: Tue, 21 Feb 2012 21:22:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120221202223.GE7024@...1296...>
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
	<CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
	<4F43D9B0.6010900@...1114...>
	<CAOazyz0Z4Lv=qDN1r_W504vBOgaF1YWiNs+9j_MCorACOzfyzQ@...278...>
	<4F43EE92.50802@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72btQdUC6twB1rwh"
Content-Disposition: inline
In-Reply-To: <4F43EE92.50802@...515...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

--72btQdUC6twB1rwh
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2012 at 09:20:50PM +0200, Samuli Sepp=E4nen wrote:
> Also, ecrist publishes source tarballs every couple of weeks already...
> couldn't these old autotools users use those and still get failrly
> recent OpenVPN versions on their boxes?

Exactly.

You need autotools if you want to build "directly from git", and the
group of people that a) use git versions, b) use ancient operating=20
systems (that *do* have tun/tap), and c) can't find a more recent
system to run "autoreconf" for them should be really small...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--72btQdUC6twB1rwh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0P8/6kuBuNlUUl1AQIQ2gQArcvvNCQySCBQzmdHw0FDX9GAZfVZ9tiI
7W8VRYnoemdFeeY4JbwcoAcwAKdLfOFlXYHGlz+zX9nMMVYmwARzYP3jr/pRjQF4
ilOfp4WIKMzWtpZaGoOqIYFRhRjxRHq6hwWVutIgVzfoeOQnGhyFJiIcHMF+zryb
J6QCck63oko=
=dL5N
-----END PGP SIGNATURE-----

--72btQdUC6twB1rwh--

