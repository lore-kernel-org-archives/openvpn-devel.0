Date: Wed, 16 Nov 2016 21:29:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161116202950.GM28918@...1296...>
References: <1479302092-28406-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TMLNKRy1XHetvtmT"
Content-Disposition: inline
In-Reply-To: <1479302092-28406-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] configure: check for AEAD function
 declarations, instead of linkage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--TMLNKRy1XHetvtmT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 16, 2016 at 02:14:52PM +0100, Steffan Karger wrote:
> One might want to run ./configure before building the crypto library.
> To correctly check from AEAD support in that case, check for the
> function declaration, rather than trying to link to it.

Semi-Feature-NAK - I'm not convinced by the need to have this (your
setup is a bit unusual in that respect).

OTOH: if someone who understands Autoconf better than I do tells me that
"checking for the headers" is the "better" approach here than "trying to
link" I'm not going to block this.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TMLNKRy1XHetvtmT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCzBvqkuBuNlUUl1AQILwAP9F+SwRT0PXa/vhWd1H+2YgAZGrRoeOXYP
AkkpAe3ka1IuIibx47YgqkoMjCGhrSok5VFXRB5SLOACtk2VrIbvHw47koJgrp8B
xQEik6Tkg7qV6/nDaL1Yn9eUUAis4sD26Cbup1YEZvFyxj7vAgP6JfOtkL2tzdq/
JoEDI21jqd0=
=eFS1
-----END PGP SIGNATURE-----

--TMLNKRy1XHetvtmT--

