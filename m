Date: Thu, 16 Feb 2012 19:23:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120216182350.GK7024@...1296...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-2-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
In-Reply-To: <1329413441-22538-2-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] replace check for TARGET_WIN32 with
	WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 16, 2012 at 06:30:38PM +0100, Heiko Hund wrote:
> Use of TARGET_WIN32 breaks MSVC builds as it is only defined
> for mingw builds done with the autotools buildsystem.

ACK.  I think it's reasonable to have exactly one CPP symbol to=20
identify "building in the windows 32bit environment".

I have no particular preference, and there are less TARGET_WIN32s in
the code - so get rid of that one :-)

(Yes, we should get rid of all the windows build cruft, but the focus
for now is "have something that *builds* and can be tagged as 2.3-alpha1").

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz1JtqkuBuNlUUl1AQKtawP9HK3Dz4meo8o7ruPzlI6gvOOJJrZdfEcO
UBDMYPWDCsNkDXmDIldLjKTuU40J8tPg8AHNOmLijVtIkQZBU8ozjz5fQ4IgNzHu
dlYA16dcPZPVNAGb1Nu7juClduVEZ5x0298Gfa3FSISygvU4UDqWVWY8i6u9IAGP
Vl89254bbMw=
=yCPG
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--

