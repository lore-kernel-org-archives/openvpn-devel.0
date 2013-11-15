Date: Fri, 15 Nov 2013 22:45:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131115214547.GU161@...1296...>
References: <1384535524-6366-1-git-send-email-dazo@...384...>
	<5286670F.9080404@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MekdDWo5JqZA69XK"
Content-Disposition: inline
In-Reply-To: <5286670F.9080404@...68...>
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: Check for fping/fping6
	availability
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--MekdDWo5JqZA69XK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 15, 2013 at 07:25:19PM +0100, Matthias Andree wrote:
> > +# Check for external dependencies
> > +which fping > /dev/null
> ...
>=20
> NAK.
> which is not a POSIX command,
> so you may introduce false skips here.

Which platform is it missing?  My spot check found it on all BSDs,=20
MacOS X, OpenSolaris and Linux (Gentoo, CentOS and Debian), and that's
pretty much everything where we expect this to run.

It might be missing on "Oracle Solaris", but I'm not sure how much
relevance this has a test/development platform for us, as none of the
active developers has a Solaris machine that is turned on most of the
time...  (I do tests on OpenSolaris, but my old Solaris/Sparc64 systems=20
are off most of the time).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MekdDWo5JqZA69XK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUoaWC6kuBuNlUUl1AQK9SwP/aDzxou0xXPLx0TuenDt7GCr3owVw1Mtm
ATagBBB1vygJo9/xTzlHnGU9hPkAn5ipKm1nfy9f/P56EEgnXlvbhWzSsZ54kQLa
t5xRXKIht70npCiW5vl2Kitc5t5K9YM6XWXoPQP/n6cd+NVv2pRwZ4pdyPeebd/+
VPNA5c/z9uA=
=iyY2
-----END PGP SIGNATURE-----

--MekdDWo5JqZA69XK--

