Date: Fri, 12 Aug 2016 20:45:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160812184556.GG78279@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471023669-25102-1-git-send-email-gert@...1296...>
	<CAKuzo_jySkzG-fHJzz79-EvScbwnaN_PwD+e4dv17=WCxpagvA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLCsp91D2sDKcV7m"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jySkzG-fHJzz79-EvScbwnaN_PwD+e4dv17=WCxpagvA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Change timestamps to ISO 8601 format.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yLCsp91D2sDKcV7m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2016 at 02:25:54PM -0400, Selva Nair wrote:
> > +- all time stamps, including log file, status file and management
> > interface,
> > +  are now output in ISO 8601 standard format.
> > +
>=20
> Currently the >LOG message to the management is like
>=20
> >LOG:1471025385,,Closing TUN/TAP interface
>=20
> with unix time as timestamp. Similarly for INFO message in response to 'l=
og
> n' request or the state message.The patch would not change those, would i=
t?

Those wouldn't be affected, no.  Only those that have the "old" ctime()
format today - what I spotted on the management interface is "status"=20
output, both in the header and in each idividual client line.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yLCsp91D2sDKcV7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV64ZZKkuBuNlUUl1AQIH9gQAmiOGxDOWzdQlP26ilfGxemf3kfBOWLkj
AYH9dLoGA1sDDs4CkDXEicHCoOmCJpQoX16+g1QRpA3VqjGLlO/WYjQFiHxNupci
y/p5yaa/zGAIoj8IZSUjvSx4oARr5GX+AkTuW9MvuyXMeN6pssCCBE1um8c8UGwO
FTWci5/r03M=
=Wwod
-----END PGP SIGNATURE-----

--yLCsp91D2sDKcV7m--

