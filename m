Date: Fri, 20 Aug 2010 18:20:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100820162047.GA10703@...1296...>
References: <20100820154817.GC23371@...1296...> <1282319811.19580.2@...1207...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1282319811.19580.2@...1207...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (19th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 20, 2010 at 10:56:51AM -0500, Karl O. Pinc wrote:
> On 08/20/2010 10:48:17 AM, Gert Doering wrote:
>=20
> > The app is cross-compileable today - but to make that work requires
> > that=20
> > all relevant Windows APIs are exported in mingw headers *and
> > libraries*.
> >=20
> > Windows APIs have the nasty habit of changing over time, so if mingw
> > stops updating their libraries etc., OpenVPN would be sort of stuck
> > to the old APIs - which might turn into a problem.  Or might not.  We
> > don't know...
>=20
> You could also say that, for instance,
> gcc might not keep up-to-date and it'd be better to use, say,
> the Intel compiler which is faster anyway.=20=20

Which C compiler to use doesn't really matter, as long as the C compiler
(and the system libraries) presents all necessary APIs for this platform.

> What makes mingw different from gcc?  It is really in such danger?

mingw has the same problem as WINE: it's following a foreign API that's
beeing extended and changed regularily.  It's not "the native platform
environment", so they always have to play catch-up.

Don't get me wrong, I'm a big fan of mingw - I'm just explaining why
this could be a problem if, for example, Windows 8 needs a new way to
configure IP addresses on a tap interface and the necessary API is just
not there in the mingw environment.

> I've had fewer problems with open source projects being
> discontinued than I have had with proprietary products.

Well, I've had my share of stale and unmaintained open source projects,
and also of commercial pain.  OTOH, the assumption that microsoft will
continue to provide compiler environments for their OSes is not fully
unwarranted :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTG6rX6kuBuNlUUl1AQKuhQP8D8aBQiLt39Tc5DCOlVcq0KcYGyVBT99h
e7hxA1OAZuedw5Pp9LOcuObZMIYc4l82j3TwikNsg2G3mzcVkx/BvMCu+xI4S99X
Ejy6Lh7vQtkS6qjXo5nTrqhwM1RMzOgrINrDZKFJRZSPMUHruyf+NXjlOh4ihojD
CPkpK2vYyAs=
=Sq0Y
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

