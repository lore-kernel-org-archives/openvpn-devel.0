Date: Thu, 6 Jun 2024 22:24:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZmIa6IRF-Z_AxFmB@...1296...>
References: <20240606103441.26598-1-gert@...1296...>
 <202406061133.456BXOgs047085@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HoJ6xnNax2O8l9AY"
Content-Disposition: inline
In-Reply-To: <202406061133.456BXOgs047085@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement Windows CA
 template match for Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Wundram <heiko.wundram@...2614...>
Cc: openvpn-devel@lists.sourceforge.net

--HoJ6xnNax2O8l9AY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 06, 2024 at 01:33:24PM +0200, Gert Doering wrote:
> As instructed I have removed the "and fallback requested" part
> from the comment where "fallback" was removed from the code.
>=20
> Your patch has been applied to the master branch.
>=20
> commit 13ee7f902f18e27b981f8e440facd2e6515c6c83 (master)

... and to release/2.6, as this functionality is seen as useful, and
the change is very non-intrusive.  So it will be part of 2.6.11
"release planned in about 2 weeks".

commit dfbe11ac1842df400327be22951d0ba373534254 (release/2.6)
Author: Heiko Wundram <heiko.wundram@...2614...>
Date:   Thu Jun 6 12:34:41 2024 +0200

    Implement Windows CA template match for Crypto-API selector


Compile-tested via GHA.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--HoJ6xnNax2O8l9AY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmYhroAAoJEB2Cnv7KVigSeNwL/31Im80MSluyXagtI2kYzWE3
DpW+JeudRg5MbarZW0VVWozpiK4c4j67qeMJstxAOee+J0rWhe+gn76FUGnEWbOI
QYzS6+R+alDu1OBVpilCDDQfNz3hpck9cULX20MmmwcfTYMO4oFpPRCBa3qKNMWe
Q2PMetiDaH7LwcCmnjyEvIIDAYpzfWBEZ8IKNxacxs1UJiya9vMoDN6Tw9OS/l4P
w5FYNTpem1Hi/ah9meb6oLTEPACuoIOaTdCPewi0PFy8G/KfNwVCyy83eY4HtQrj
WmUtalDRLcLQop+xLgBbc9zhy9BwdrOQlDaxm7l4PuS0tPFcwjcjEh9n7BJtst+j
zmdRsSSrPwVU99k2lLcGp0sV3dk7HnL4TDd6Pqn5mLyatiLxjx9GrVnTb4s2pY+G
vvYLeYAsY9Ncr8BRGPNzJukEiATp9e40h6m4qoNdtfg03SHseh8RnuspoNX7r3xe
niOLle9Xu+PJTE/88pyoDiiXl/cvhaIcwY6ORVhycw==
=x72t
-----END PGP SIGNATURE-----

--HoJ6xnNax2O8l9AY--

