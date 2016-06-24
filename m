Date: Fri, 24 Jun 2016 19:33:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160624173327.GX79504@...1296...>
References: <20160624140526.GV79504@...1296...>
	<CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
	<20160624152932.GW79504@...1296...>
	<576D59FE.90507@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PLVMksexArUZ/iL3"
Content-Disposition: inline
In-Reply-To: <576D59FE.90507@...2080...>
Subject: Re: [Openvpn-devel] brainstorming: t_client system test equivalent
 for windows?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--PLVMksexArUZ/iL3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2016 at 06:04:14PM +0200, David Sommerseth wrote:
> > Perl has the advantage of being available on all platforms (or at least
> > "you can install it", I know it's not there out of the box everywhere)
> > so maybe we can do a common test driver implementation that runs on
> > windows and unix, so less maintenance...
>=20
> That argument can be said about Python as well.  And there's a lot of
> different testing resources for Python, a lot of them are unittest
> oriented (so not so directly interesting for us) but there are others
> which also "drives" external test cases.  Beaker [1] is the one I've
> worked most with, but that is overkill in this scenario.  But there are
> most likely lots of stuff we can extract and reuse too.  And there are
> several others which I don't recall right now.

The point is not so much "running arbitrary tests" but "controlling=20
OpenVPN in a scripted way" - what t_client does as a shell script today.

> We might also consider if there are possibilities for us to integrate
> such tests with Travis or similar stuff for platforms where that is
> possible.  Often these solutions have Python or Ruby modules available to=
o.

While totally interesting, how is this going to help with *Windows*=20
testing (which is what this thread is about)?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PLVMksexArUZ/iL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV21u56kuBuNlUUl1AQIPoQQAlxL2ZcqnqGNnbSVdP42ebnHzaK37ZiTn
MePtPSN0SRR1JBmjegPXuQZvSwTonns+n9pTaqePxaHlLCqXsKdjFaZHrG7yNJ1+
/Kh6/eFrkXYbhkpUGQcKkqZav7rlZHC7/iALEuc6fkwMCx7i5cLyvr680oMuHB7d
vswH8BzKWjc=
=x/+y
-----END PGP SIGNATURE-----

--PLVMksexArUZ/iL3--

