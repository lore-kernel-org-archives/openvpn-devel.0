Date: Tue, 9 Sep 2014 22:24:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140909202408.GK1118@...1296...>
References: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
	<1410283573-17933-3-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7SmwMmrgk1+hXSn"
Content-Disposition: inline
In-Reply-To: <1410283573-17933-3-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Clean up the pipe closing in
	openvpn_popen()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--H7SmwMmrgk1+hXSn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 09, 2014 at 07:26:13PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> Do the proper closing of the pipe ends which is not being used,
> also in error situations.  Moved the closing of the parent side
> before the waitpid(), to be consistent with the child side (as
> early as possible).
>=20
> Also improved the error messages with more details.
>=20
> [v2 - Don't call close() if execve() fails]

ACK.  Looks good to me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H7SmwMmrgk1+hXSn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVA9h6KkuBuNlUUl1AQJFCwQAjixBc57CXJNtb5s2KIDWLEhSlmHntSXq
+TP+Jez9Dfq4821HUD+ljJpYa3RT3AABSONEobY4nHtGAG7z9c2Opt+77Z/rcDNS
Jzddzpbg7YXrCog7MV1qbLbu2CLZ6uZ7nQvZa2esJyd04EXl1Mx/SbQndU1heLD8
VbVVMWV4x1Y=
=2pg5
-----END PGP SIGNATURE-----

--H7SmwMmrgk1+hXSn--

