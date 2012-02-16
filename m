Date: Thu, 16 Feb 2012 18:47:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120216174753.GJ7024@...1296...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-5-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qLni7iB6Dl8qUSwk"
Content-Disposition: inline
In-Reply-To: <1329413441-22538-5-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] make MSVC link against shell32 as
	well
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

--qLni7iB6Dl8qUSwk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 16, 2012 at 06:30:41PM +0100, Heiko Hund wrote:
> Windows API CommandLineToArgvW(), introduced in Windows unicode path
> commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a, is defined therein.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>

Since you've tested it and it makes Samuli happy -> ACK :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qLni7iB6Dl8qUSwk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz1BSakuBuNlUUl1AQIYmQP5AdXxI4Lvzuv2XSfViAN3jA47b1VDf1gM
uGzIyYPD95SE6oUTZNZLP6Wj/Wm1fnVRKmGTqxMD+pQsiSlTI3gE0h3sHWpB6XAh
w7yWzYMvGHuHEzQVmzIAtIksrpOO94PMTPbCTA9U+pR70Sg1V/1xFFMfgtKt0cDF
jiZMAgdIkHg=
=VHTB
-----END PGP SIGNATURE-----

--qLni7iB6Dl8qUSwk--

