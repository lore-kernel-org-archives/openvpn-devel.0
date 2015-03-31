Date: Tue, 31 Mar 2015 19:19:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150331171938.GK21893@...1296...>
References: <5519B242.2020009@...1856...>
	<20150330210636.GF21893@...1296...>
	<551AA3A2.5000300@...1800...>
	<20150331142352.GI21893@...1296...>
	<551AAF8F.7010502@...1800...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pK9RtcSsLPP6O/Rn"
Content-Disposition: inline
In-Reply-To: <551AAF8F.7010502@...1800...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FreeBSD+cryptodev testers wanted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Tancsa <mike@...1800...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

--pK9RtcSsLPP6O/Rn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 31, 2015 at 10:30:39AM -0400, Mike Tancsa wrote:
> On 3/31/2015 10:23 AM, Gert Doering wrote:
> >On Tue, Mar 31, 2015 at 09:39:46AM -0400, Mike Tancsa wrote:
> >>I am not able to reproduce this.
> >
> >You need to use --daemon to make openvpn fork().  Otherwise, it will
> >"just work", but after forking, the cryptodev file descriptor is no
> >longer valid -> boom.  Steffan's patch should fix that.
>=20
> Hi,
> 	Is having in the config
>=20
> daemon openvpn-hq
>=20
> not the same as --daemon from the arguments ?

It is, sorry, did not look closely enough.

The fact that this just works for you is... surprising.  So maybe it's a=20
different FreeBSD version, or different openssl, or whatnot...  unfortunate=
ly,
the original bug report

  https://redmine.pfsense.org/issues/3966

does not list FreeBSD version or OpenSSL version, only pfsense version
(2.2) - which does seem to be FreeBSD 10.1-p4, though...

Mmmh.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pK9RtcSsLPP6O/Rn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVRrXKqkuBuNlUUl1AQJblQP/a3dm40w0+W/Vl+ZW+PelmyPJ8PSdAQEo
TDSNL5zEFqJjtucZp3C/TK4QDH3GJfJJzebY/fjeuAyGMpHw8JiBzBvo5KTwsXRn
B7ugs9vO2Quq87mbhxM244GqbaSOIO3zIjnSFUjgqibC7DRo/whLwRmTRyafdoZD
S73zEciRc5k=
=kSRu
-----END PGP SIGNATURE-----

--pK9RtcSsLPP6O/Rn--

