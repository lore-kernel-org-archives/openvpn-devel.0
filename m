Date: Wed, 27 Jan 2016 09:20:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160127082046.GY24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
	<56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
	<56A87C5A.3050104@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2sDral3r2IiLph9T"
Content-Disposition: inline
In-Reply-To: <56A87C5A.3050104@...515...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--2sDral3r2IiLph9T
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 27, 2016 at 10:14:18AM +0200, Samuli Sepp=E4nen wrote:
> An added bonus is that openvpnserv2 is written in C#, which means it can=
=20
> be developed on Linux using Mono, and the language choice probably helps=
=20
> getting new contributions from people not fluent with C.

I'm not totally convinced that "mixing in a new language" is a *bonus*
(as it means that the core team won't be able to help unless also fluent
with the other language).

Given that services run with maximum privileges, strong review is as
important there as for core openvpn...

If the only reason why everyone is disliking the old openvpnserv is
"it is not restarting openvpn.exe when it breaks" - *that* should be=20
fairly easy to add.  So, what is that people consider "broken"?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2sDral3r2IiLph9T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqh93akuBuNlUUl1AQLtkQP9FgXaOkD8f1/UVMZtR9SXfuxmueHWHStc
ov8pMjpif+3uOaDaQp9gmH1VZ4uoMjMSDerHmH3CWveeocvA8/qaQ7ne2UQvwIsm
w/8vijNwVlwZ8OdUr6sEKHe/EBXNi3D28ao6rPDwTxOPZEVEO/1CFIww/Te4m1/Z
+0khRAiyILo=
=Z4AL
-----END PGP SIGNATURE-----

--2sDral3r2IiLph9T--

