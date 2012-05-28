Date: Mon, 28 May 2012 20:57:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120528185705.GA1161@...1296...>
References: <20120527202737.GV1161@...1296...>
	<CAOazyz0LD6ykOFcxcRTvu95Sjkzcsg2+FxT7514Ki3+QW9Dbsw@...278...>
	<20120528075212.GW1161@...1296...>
	<4FC36AAB.6050806@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <4FC36AAB.6050806@...515...>
Subject: Re: [Openvpn-devel] build revolution lost t_client test?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 28, 2012 at 03:08:11PM +0300, Samuli Sepp=E4nen wrote:
> I don't really care what the make target is called. It could even be an
> entirely different target. Buildslaves could easily run "make check"
> followed by "make root-check", "make connection-test" or whatever. If
> nobody outside the core project is supposed to run the connectivity
> tests, I think separating them from "make check" would make sense.

Nobody who hasn't set up a t_client.rc beforehand will be bothered by
the client connectivity tests anyway - "make check" will tell him=20
"rc file hasn't been set up, skipping test", and that's all of it.

So while I can see some purity of argument here - in the end, it's=20
wasting human life time on discussions again, and the time could be=20
better spent on what's sorely missing right now: automated tests
(unit tests, client system tests, server system tests).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8PKgakuBuNlUUl1AQKeLgQAolHYTQDycAGI+ztBYdKzc4aREcHhwflx
PrQ4eJQHv2gXQ10mkaxfddOvVuQ/rQpXiH+Yln8ExnMf5FmInFRfUzuRBlQxkAuZ
Vl8X+X69rGLyjB43K7uXXDE3aHx4TQghlECfYSSWfEH6O9TCWvNP+SJTB/AD+mI0
NltDi5fG4oo=
=pbLL
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--

