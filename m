Date: Wed, 22 Jun 2016 19:48:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160622174841.GX79504@...1296...>
References: <1466615164-15527-1-git-send-email-samuli@...515...>
	<1466615164-15527-3-git-send-email-samuli@...515...>
	<CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
	<60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Content-Disposition: inline
In-Reply-To: <60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Clarify which Windows versions
 require which TUN/TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 22, 2016 at 08:14:31PM +0300, Samuli Sepp=E4nen wrote:
> I have not actually tested tap-windows (NDIS 5) on Windows 10, but I=20
> believe NDIS 5 support was removed from Windows 10 a while back. If NDIS=
=20
> 5 drivers still work for Windows 10 then I can definitely reword this par=
t.

A colleague of mine accidently used an I001 installer last week on W10, and=
=20
it still worked.  No idea whether it has funny consequences, so maybe word
this as "tap6 is recommended for anything later than win7" or so.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2rPeKkuBuNlUUl1AQK6zAP8Dzs8IDIaLXcTt8NngsgVrA6Oisj0ySMM
UMvnbOHl2Bllmfxp2tX8ezJ7Puv+yXTm3Gnwz8uy5d2l1bmahtADP/EWSPmgp8wY
0yY0kg1fIh0zQ4PfBNYb6KH2ErmE/iICwiNxn/aZPOJ1UO8ywbsxhb7Bve0jLcDs
Ob+q4zIkwNc=
=yPhq
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--

