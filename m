Date: Tue, 29 Dec 2015 10:55:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151229095508.GK24952@...1296...>
References: <20151228100404.176a540305d85a7d3e2a2107@...515...>
	<20151228233349.7038d74f697871f66de61144@...515...>
	<C17876CFAD0D40C6859B3ABF5956279C@...2089...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdiYvl4LPr16mXQA"
Content-Disposition: inline
In-Reply-To: <C17876CFAD0D40C6859B3ABF5956279C@...2089...>
Subject: Re: [Openvpn-devel] Summary of today's (28th Dec 2015) IRC meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net

--CdiYvl4LPr16mXQA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 29, 2015 at 12:21:06AM -0000, debbie10t@...277... wrote:
> > Discussed the OpenVPN 2.3.10 release. IPv6 support for Windows XP is=20
> > broken right now
>=20
> Bit surprised so tested :-
> 236-I00x-i686 - ipv6 ok
> 237-I00x-i686 - ipv6 ok
> 238-I00x-i686 - ipv6 ok
>=20
> 239-I00x-i686 - ipv6 *not* ok

We're fully aware why this is broken, and it has been already discussed
on the mailing list :-) - so nothing to be surprised about.

(The "use interface index in argument to netsh.exe" patches break XP, as=20
XP-netsh.exe does not understand interface indexes - *sigh*)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CdiYvl4LPr16mXQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVoJYe6kuBuNlUUl1AQJG2gQArGlIvZvy+6rNl8SYYEZRLwoNGcehCER9
PWw2kWhrjs0+1InD80z5Orx09oCAYJZeT+GiNlE3Jl5ZnU2dF92phWkE2M3Np8ad
CNpaJg7hcVHfaA5mxI7HzdXYLeyl3sSSXlCgH4gLIzcr8qvAZx76SSL2Ha3mpKez
fK4NjWnvfkE=
=Im9B
-----END PGP SIGNATURE-----

--CdiYvl4LPr16mXQA--

