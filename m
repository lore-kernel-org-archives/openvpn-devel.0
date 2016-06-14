Date: Tue, 14 Jun 2016 22:34:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160614203421.GA62247@...1296...>
References: <ec25d8af-ecfe-19eb-9d86-4525300cde2f@...277...>
	<CAA1Abx+q7EVw1tD3mbdn2g016pL2KXjoNQ9FodVzvDAr+zyw0w@...278...>
	<20160612173454.GV62247@...1296...>
	<CAA1AbxLrE-xdehgXPhk0XbQnWLffBeAduLhEsp7Bh2TBUR61zQ@...278...>
	<20160612180939.GX62247@...1296...>
	<CAA1AbxKKny9inQLpW3OcPLUJ5ozb_Wzb87kw9h-EFVdk9UPXMA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2d+m75Tjo442KmM"
Content-Disposition: inline
In-Reply-To: <CAA1AbxKKny9inQLpW3OcPLUJ5ozb_Wzb87kw9h-EFVdk9UPXMA@...278...>
Subject: Re: [Openvpn-devel] OpenVPN-mbedTLS depends on mbedTLS debug module
 - safe to remove?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G2d+m75Tjo442KmM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 12, 2016 at 08:57:49PM +0200, Steffan Karger wrote:
> Right, of course.  Sorry - too tired today.  That would be #ifdef
> MBEDTLS_DEBUG_C, and totally makes sense.  I'll send a patch.

commit b63f98633dbe2ca92cd43fc6f8597ab283a600bf
Author: Steffan Karger
Date:   Tue Jun 14 22:00:03 2016 +0200

     mbedtls: don't set debug threshold if compiled without MBEDTLS_DEBUG_C

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--G2d+m75Tjo442KmM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2BqTakuBuNlUUl1AQKU3gQAuJaxkC/Pkq1S6d/3kVfkb/M6y+sd1cmR
BKxUgOTHtRO81regpwEhb5sxLoB5JPmVcCmQKMhB6vrPov0oj0V/wD1qzrb4xgjc
OR04BSn+N3s96UiV0nMRVg6ywX0SgCqkMt1xRpAdOHy5v7Ly/30N7gk28qCVRl6L
wP76xwKC8KU=
=2Ifh
-----END PGP SIGNATURE-----

--G2d+m75Tjo442KmM--

