Date: Tue, 7 Jun 2016 16:41:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607144127.GY53051@...1296...>
References: <CAFHpkQFkm-6FUUs8DN63UKKHCPHZBmLDK1fk60xaycUk3K5GSQ@...278...>
	<CAFHpkQEjE6vmRm3-Mq_9i3A2w5TrcJ4rasxoZwf00W+sPh3DDQ@...278...>
	<CAFHpkQEt1tH5yPY-9=G6YRuardSBM7CtsDLOHd71JHHUQBtOwQ@...278...>
	<45ec7635-8bb5-f811-9b8b-4713091d79ee@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="13lc0+mu8fJIQQlu"
Content-Disposition: inline
In-Reply-To: <45ec7635-8bb5-f811-9b8b-4713091d79ee@...515...>
Subject: Re: [Openvpn-devel] Valgring findings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--13lc0+mu8fJIQQlu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 05:33:07PM +0300, Samuli Sepp=E4nen wrote:
> > I played with valgrind a bit
> >
> > https://travis-ci.org/chipitsine/openvpn/jobs/135869065
> >
> > Looks like there are leaks in openssl code, should we suppress it?
>=20
> I can't comment on the leaks themselves, but I wonder if it would make=20
> sense to run OpenVPN under Valgrind in "make check". For example, when=20
> using the Vagrant test VMs the loss of performance would not be a big=20
> deal - the tests would just run quite a bit longer.

Unless you can whitelist certain findings, valgrind output will be LONG
(as can be seen in the URL above), and we can't do anything about memory=20
lost by OpenSSL etc. - so it's just long output of random numbers, which
nobody will bother to look at.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--13lc0+mu8fJIQQlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1bdF6kuBuNlUUl1AQL2RgQAmsDfn/kjQ6remNIlXE9Hr1GDagxlGvN5
gysudj1JZdwfcAShqVvRQLvwATYPcrWqVGii8ZjbR1wYWam3BQF0/z6NardHQeOI
1hrGdmItZWAohvs2AskO3XEbr2FpGrVYDxco4Ce3eqdDECK++mvG6YRrmpLmznU+
ITaJOW4Vr5I=
=843T
-----END PGP SIGNATURE-----

--13lc0+mu8fJIQQlu--

