Date: Tue, 31 May 2016 16:23:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531142322.GW53051@...1296...>
References: <1464690813-10411-1-git-send-email-openvpn@...2080...>
	<1464703645-26640-1-git-send-email-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7bffuAVp0yYfOhc"
Content-Disposition: inline
In-Reply-To: <1464703645-26640-1-git-send-email-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Only build and run cmocka unit tests
 if its submodule is initialized
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...2145...>

--C7bffuAVp0yYfOhc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2016 at 04:07:25PM +0200, David Sommerseth wrote:
> +   AC_MSG_RESULT([!! WARNING !! CMake is available.  Unit testing cannot=
 be performed.])

NAK, as this should be "CMake is NOT available" - otherwise, I would be
happy to ACK it :-)

The rest looks good.

(See my comment on IRC for "do we want all these patches in 2.3", though)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--C7bffuAVp0yYfOhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV02eWqkuBuNlUUl1AQLk9gQAvwmCnVcaRmErrhP/3MY9AXhAu5j1jqas
QA+otvT4hwQVE4G55aPQyhe86jAlPdbxzxwk+kABw1c5aGedsN38vkkyMOkBuHN6
bzzgFu13De7qTYFKtjkgHZXqA8xDdusZAiE1wTw9BG+FffJElAmaQyDalMht4aK0
vnPhV4l1BdI=
=H++m
-----END PGP SIGNATURE-----

--C7bffuAVp0yYfOhc--

