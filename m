Date: Sat, 22 Nov 2014 11:21:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141122102138.GA17158@...1296...>
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>
	<CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>
	<54705AA4.2010105@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <54705AA4.2010105@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 22, 2014 at 10:43:00AM +0100, Steffan Karger wrote:
> On 21-11-14 20:43, Yegor Yefremov wrote:
> > This patch is a result of our IRC discussion with Arne. Alternative
> > approach were to always build with password-save functionality without
> > configure option at all.
>=20
> Thanks for the patch. But this explanation doesn't help me much in
> understanding why this feature needs to be enabled by default. Could you
> please explain?
>=20
> (My first thought would be that locally storing a password defeats the
> purpose of the password, so it is a good thing this is disabled by
> default. But good arguments might change my view.)

My thoughts are along the line - yes, there seems to be a discrepancy
between what configure claims to be the default and "the real default",
but should we change the actual default here, or the configure help
message?

Given the previous discussions, there seems to be belief that this is=20
a "dangerous feature" that should be "turned off by default" - so I tend
to, for the sake of consistency, not change the default but change the
configure help output instead.

... which makes this a feature-NAK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVHBjsqkuBuNlUUl1AQLDcQQAwhEWX06fjq/tIz7SegW2QTHRqMV5cwtq
UjBAfSt9nhNQlus7fJrAUGpg7ao0zR6ehtZ2Aj56shUaPMppNAz3J2gRna+ypZOO
o65NqDVmPSaen3IUALEOE734bAFp3OKoIIIJc38S9I59oai/fOYBg6DVeusEeubM
XlRaStWxf18=
=XfB+
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

