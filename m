Date: Wed, 23 Nov 2011 11:31:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111123103131.GB8496@...1296...>
References: <1321619990-12173-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PYZVBlM1Xft6NkOI"
Content-Disposition: inline
In-Reply-To: <1321619990-12173-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Make '--win-sys env' default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--PYZVBlM1Xft6NkOI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 18, 2011 at 01:39:50PM +0100, David Sommerseth wrote:
> Without this patch, the default path used by OpenVPN is hard coded
> to C:\WINDOWS.  As users might install Windows in a different directory,
> this approach will cause OpenVPN to malfunction in some configurations.
>=20
> OpenVPN have supported using the system path, by adding --win-sys env.
> This patch removes the hard coded approach and uses the --win-sys env
> approach by default instead.

ACK.  Both on the concept and on the actual code change.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PYZVBlM1Xft6NkOI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTszLgqkuBuNlUUl1AQKfsgQAwKuSfXpkpXv1fJAqaCPli3Q4mpGhoTgH
N4a2MPYfWHvdaAg2/i27iLbNm1ig2oFwTSmUzVxzVjnnfYT+rzDxnf5LTnqVal21
expd8SxIYvRE/Zxg/Ih68N+LfnTl18tcoI935E/eaeCehwCS9Nee1EEAmZH1da4k
3+r87w8dZ5E=
=lwGs
-----END PGP SIGNATURE-----

--PYZVBlM1Xft6NkOI--

