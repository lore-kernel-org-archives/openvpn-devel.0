Date: Wed, 21 Jun 2017 18:02:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170621160218.GY97029@...1296...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
	<20170621151835.GU97029@...1296...>
	<103f1dec82c50941570c7103355b8457.squirrel@...2257...>
	<20170621154928.GX97029@...1296...>
	<41fdab48-8ce0-0734-9829-a17206a9fbcc@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CykJmXQjLoWzTnSU"
Content-Disposition: inline
In-Reply-To: <41fdab48-8ce0-0734-9829-a17206a9fbcc@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--CykJmXQjLoWzTnSU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 21, 2017 at 05:58:18PM +0200, David Sommerseth wrote:
> Hmmm ... not a bad idea.  But do we really need tar.gz at all these
> days?  Why not just make autotools generate tar.xz by default and be
> done with it?

"distcheck" tends to just do .tar.gz - can you make it still do the check,
but produce .tar.gz?

> Or to put it differently: Which platforms lacks lzma/xz support these day=
s?

plus "what platform needs .zip", as in "seriously, so often that the 3
persons unpacking OpenVPN source builds on Windows will not have 7zip
installed anyway"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CykJmXQjLoWzTnSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZSpiJAAoJEB2Cnv7KVigSH9YMAJXkLmJMTdTPPI17kulJPoTG
65ndKfR9ERApJsni2KyEdWC1RITZPueYj2+0QCmKWkQSsMAFKRPBemowiBUjT21s
WMABNRxYU8PU3Jpno83QbKU76roeO80RwCdy2Aa++FmSg/ln0CqGVIezchE3CxLJ
ylesRbBLeZ2on+Br3ooyl6sq0TcgZ0luHVG4yPY9aLqbRxlaoAhXyLJ4vBpnHBeB
nWTTIaxZjkA7LJKJJWGfL037geuWrlKKLJIBfpaogfp2Hv2MVfFt2jky6i3kM8cc
6xqrjbOhEmAIJyPotFoZHEwtbLcvCxxgtcaTEpEHxrfI6uRiLTFAe5prbcEmss33
BONsEh6QO+6IQ5uv6chlGKXoEH0X6U+LDcQ4GSdI3IkaSoggLXBoIChm4zon7HMb
ylAVBk9isd60tVsFpzXonqTe07YJAe1M950+Zs47jXvFf0JZEQak4KGIJdiUMesL
zXaGar46se4psjLrFgIqPmAYzhaoOvYfANi6guy4Jg==
=m6RK
-----END PGP SIGNATURE-----

--CykJmXQjLoWzTnSU--

