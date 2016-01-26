Date: Tue, 26 Jan 2016 22:24:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160126212431.GW24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
	<56A7D1F6.8030805@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VGjZH5CcFM/FCmgL"
Content-Disposition: inline
In-Reply-To: <56A7D1F6.8030805@...515...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--VGjZH5CcFM/FCmgL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 26, 2016 at 10:07:18PM +0200, Samuli Sepp=E4nen wrote:
> One question, primarily to Heiko... does the interactive service solve=20
> the use-case where the administrator/user wants to have persistent=20
> connections that come up on boot and are not closed or managed in any=20
> way in the meantime? In this use-case no user interaction is wanted,=20
> needed or expected.

As far as I understand, the interactive service is fully controlled by=20
the GUI ("hey service, run *this* with my credentials, but permit it
to talk to you and request route changes").

The "openvpnserv.exe" process can now actually run as two different=20
things - the classic "openvpn service" which just starts openvpn.exe
at service start time, and the new "interactive service" which helps
the GUI for, well, "interactive" openvpn usage.

Since Heiko has reworked the "classic" code (in automatic.c now, as
he called this "automatic service") maybe we can just use the opportunity
to get the remaining issues fixed - is there more than "restart openvpn.exe
when it dies"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VGjZH5CcFM/FCmgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqfkDqkuBuNlUUl1AQLBxQQArdgBFbtqEpPEFaSjGin/awwOQYCsC6t9
4Ej01WgPQ6YaxY84pxVM2hQFZzykEM++boMdX9bwLX6Pmoe/Bq6i5jgdb222ZrcX
XNk2027vZc4mh6OfvHpzVkho9Uga22jxuNOrd4bk509PksEUpVZwdTqUfIGI5Y4+
BUQbggTdhHY=
=qGrk
-----END PGP SIGNATURE-----

--VGjZH5CcFM/FCmgL--

