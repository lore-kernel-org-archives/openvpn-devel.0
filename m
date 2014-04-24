Date: Thu, 24 Apr 2014 16:56:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140424145646.GR16637@...1296...>
References: <CABBOjCJuPbKa-ocaqVQDtFT3PreE=GrZPm0Dv_12o1A14ZNkBA@...278...>
	<CABBOjC+m6LTk+TYtCXswYH017GAh7CFe8tSqOOr-idR+q_dTfg@...278...>
	<1398345955.723.137.camel@...1904...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qnfu63SIQi34A1vx"
Content-Disposition: inline
In-Reply-To: <1398345955.723.137.camel@...1904...>
Subject: Re: [Openvpn-devel] TAP adapter detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Greg Toombs <gtoombs@...1905...>, openvpn-devel@lists.sourceforge.net, openconnect-devel@...1906...

--qnfu63SIQi34A1vx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 24, 2014 at 02:25:55PM +0100, David Woodhouse wrote:
> On Thu, 2014-04-17 at 17:01 -0400, Greg Toombs wrote:
> > Found the problem. tun-win32.c:45 -
> > #define TAP_COMPONENT_ID "tap0901"
> >=20
> > This is only valid for the most recent version of the TAP adapter. For
> > other versions, this should actually be "tapoas". So openconnect
> > saying that there are no TAP adapters is incorrect. Instead, it should
> > check all known component IDs, and then check for the version, so that
> > instead of reporting no TAP adapters, it detects the following:
> >=20
> > Error: TAP-Windows driver v9.9 or greater is required (found 9.7)
> > Set up tun device failed
>=20
> Hm, really "tapoas"? Where did that driver come from?
>=20
> As far as I can tell from the OpenVPN revision history, they've used
> 'tap0901' since February 2007=B9 and it was 'tap0801' before that.

Yep.=20=20

There is a new one, a NDIS 6 driver, as the old one was NDIS 5 and that=20
is eventually going to be discontinued (plus, performance is worse).  But=20
the new one is still in "early testing", so I wouldn't expect people to
unknowingly use it...

	https://github.com/OpenVPN/tap-windows6
	http://comments.gmane.org/gmane.network.openvpn.devel/8342

OTOH, the src/ tree mentions "TapOas" a few times, so it could very
well be...  but that one's version.h identifies itself as "tap0901".

Dunno, have no machine with the new tap driver that I could check right
now.  Just providing references.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qnfu63SIQi34A1vx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1kmLqkuBuNlUUl1AQI8OAP+MIeyc0XOiLnZPyzX/7cxYZm5RE7pYbT2
zvA30n3VMS5WHmrR/7k97ipPHPvgygRlh5mrt6BjVXi6FI/FojSGbnUoaioIzCx7
KlvKDlELIHr4n7DimnIEwLw2ncdEzi3Iqn0TUAJWxZP152fWsquBHlHX2Lo7mTsz
2td1ER1c1ro=
=TWuH
-----END PGP SIGNATURE-----

--qnfu63SIQi34A1vx--

