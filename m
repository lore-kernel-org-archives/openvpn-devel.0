Date: Mon, 14 Dec 2015 09:22:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151214082215.GA24952@...1296...>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
	<1449794790-45430-1-git-send-email-fish.thss@...277...>
	<CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
	<014001d13605$2dec6ae0$89c540a0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4WBDOB4Uaxoy/HSp"
Content-Disposition: inline
In-Reply-To: <014001d13605$2dec6ae0$89c540a0$@gmail.com>
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
 agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--4WBDOB4Uaxoy/HSp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 13, 2015 at 04:20:03PM -0800, Fish Wang wrote:
> Will do. However, I???m by no means a license expert. Based on Licensing =
Terms page on MinGW???s website ([1], win32api), I believe the code I strip=
ped out of MinGW should be fine as long as a copy of the notice and its lic=
ense [2] is included. Please correct me if I???m wrong.

By no means a license expert myself, I think it would be good to have=20
something like "win32-api.h" (name stands to be discussed) which has all
the bits we take from MinGW with a comment and their license included
(your [2], if I'm not mistaken) - so it's totally clear where the stuff=20
came from.  Less of a "technical" design issue, but being nice about
attribution.

> [2] http://sourceforge.net/p/mingw/mingw-org-wsl/ci/21762bb4a1bd0c88c38ee=
ad03f59e8d994349e83/tree/LICENSE

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4WBDOB4Uaxoy/HSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCUAwUBVm58NqkuBuNlUUl1AQJvBAP0CjdAegcX5isyXfhO69zw2B8DPtzWY75k
s/U7mJhxeiI75OiH4ssxD5mLXeKwrHTXpZMJGNolHiWTbdgWI/pzUOsNaYaEBG4U
s9NyyB+7ivKzMf8fVJqLcbfMiNgQUFG1ZoRbr+kZ3WrNRpqUVv5xKkorMLFZGNZM
0A1fnxPN5w==
=0y8k
-----END PGP SIGNATURE-----

--4WBDOB4Uaxoy/HSp--

