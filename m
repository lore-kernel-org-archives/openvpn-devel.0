Date: Fri, 24 Jun 2016 09:15:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160624071544.GR79504@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
	<20160610165515.GG62247@...1296...>
	<CAKuzo_gkAX-5USrRi8sMvwtbxiJxCwgoi4KTOC1qtU0fpHHTvQ@...278...>
	<20160623175201.GJ79504@...1296...>
	<CAKuzo_hrvARGvhShR5NK2SB6pG0qtvnXQr_S+G17LXrGzfqD7g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azskX66S5GHWoEK7"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hrvARGvhShR5NK2SB6pG0qtvnXQr_S+G17LXrGzfqD7g@...278...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
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

--azskX66S5GHWoEK7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 23, 2016 at 02:42:18PM -0400, Selva Nair wrote:
> > So, now we have 4 different remotes.  You're scaling the exponent by 1/4
> > here, so the retry timer would be
> >
> >   5s 5s 5s 5s 10s 10s 10s 10s 20s 20s 20s 20s ...
> >
> > then (or, phrased differently, "one round uses the unscaled timer, the
> > next round across all remotes uses 2^1, the third round uses 2^2").
> >
> >
> > If I understood the math right, I think this would be useful behaviour =
;-)
> > - fast failover if multiple remotes are there, exponentially slowing do=
wn
> > if all remotes have been tried.  Plus, fairly easy to implement as near=
ly
> > all needed values are already around.
>=20
>=20
> Yes, the book-keeping variables are already there.
>=20
> To avoid aggressive slowing down, may be we could start the scaling after
> rc has reached a threshold. Say don't do anything until rc =3D 5 and then
> start scaling the timer until rc reaches 15.

I think that is a good addition to the original plan - a server might have
a hickup for other reasons than pull-reject (maybe just restarting due to
upgrades, whatever), and trying "a few times in quick sequence" before=20
going into backoff should help in these cases.

Go for it :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--azskX66S5GHWoEK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2zeH6kuBuNlUUl1AQJ9UwQApKGMNByAH6+DtrHZ97mm4WrQVu+Nwt2o
LgV4b78iVuaTZyDVchxoPGZFYiIteOdkcqCFwlmzkt6hWROpoHjQTslGoYIrqwZR
0EZR/4JUlIjBS73en+ssHj+ePyNSACkly3u9ZjyjYqnH+h3fFxVHPResAur494H5
rET8R3OsL1s=
=Xk1N
-----END PGP SIGNATURE-----

--azskX66S5GHWoEK7--

