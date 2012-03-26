Date: Mon, 26 Mar 2012 20:55:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326185547.GC1359@...1296...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz1S_As1M7RkKw7BFt3fNwM5VOz3f7qwBdDk+h+KDVM9-A@...278...>
	<4F70BA6C.1090007@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7QJU8Gl1+/xsYtC"
Content-Disposition: inline
In-Reply-To: <4F70BA6C.1090007@...384...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--H7QJU8Gl1+/xsYtC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 08:50:20PM +0200, David Sommerseth wrote:
> On 26/03/12 20:38, Alon Bar-Lev wrote:
> > On Mon, Mar 26, 2012 at 11:50 AM, Gert Doering
> > <gert@...1296...> wrote:
> >> I have now installed libtool 2.2.10, and with that, "autoreconf
> >> -vi" does not return an error anymore.
> >=20
> > Gentoo stable libtool is sys-devel/libtool-2.4, it contains some
> > fixes for mingw which I use. Why did you chose 2.2.10?
>=20
> Remember we need to support the RHEL5 platform.  That ships with
> libtool-1.5.22.  EL6 ships with 2.2.10.

For "running autoconf" or for "running the configure script generated on
something recent"?

Normally we do the latter, just the buildbots need to run autoconf locally
(and we do not have a RHEL5 buildbot).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H7QJU8Gl1+/xsYtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3C7s6kuBuNlUUl1AQLhUQP/eW0EcfXcWuSLEBRoBMzlMfgnZtTAQccI
K6DdOrAz54rjKrcNv78Mro1ioiQuYh5SDZC7wM6GBzdyTAegBIbbBeJkgt0J+BKQ
LDWgqQE2rLSpP1n4gXLd4Fk40IwdC1tDG4GKra+tU8fru1MW18vP/sDRArGouD7c
kjB1uvS/eDQ=
=FuEv
-----END PGP SIGNATURE-----

--H7QJU8Gl1+/xsYtC--

