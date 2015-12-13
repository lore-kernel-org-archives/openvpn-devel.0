Date: Sun, 13 Dec 2015 21:33:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151213203336.GX24952@...1296...>
References: <1449873472-14954-1-git-send-email-lstipakov@...277...>
	<201512131900.tBDJ0QHK007100@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6l5oCut4iRvYOGJA"
Content-Disposition: inline
In-Reply-To: <201512131900.tBDJ0QHK007100@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Use adapter index for
 add/delete_route_ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--6l5oCut4iRvYOGJA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 13, 2015 at 08:00:26PM +0100, Gert Doering wrote:
> ACK, and thanks.  Code looks good and I'm reasonably sure that it will
> do the right thing - waiting for buildbot now to produce a windows binary
> to actually test it :-) - then applying the 2.3 version to 2.3

Works!  "ifconfig" and routes are both nicely added to "interface=3D16",
which is "tap adapter v9" (and with overlapping routes, I see the /128
installed on "interface=3D10", so that is still working as well :) ).=20=20

Good :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6l5oCut4iRvYOGJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVm3V7KkuBuNlUUl1AQIC3gP8CHKYmU/lXzvyei8gR6GHKUvEExc+kK0F
Ust53E7QuwofKpXnnCtffboeuYiDMFx1taV5+jw5K0+QsjTrr/zhGKiRy7KK0flj
pOz3s+UAiVCGk3HQhQIToS3RBQFXc7XCI2Yxrk21t6z3DiUfy7Xcf+IF8yrpY50t
0zeL3K4d+70=
=tG8v
-----END PGP SIGNATURE-----

--6l5oCut4iRvYOGJA--

