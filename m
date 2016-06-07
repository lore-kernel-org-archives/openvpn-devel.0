Date: Tue, 7 Jun 2016 10:23:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607082308.GR53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
	<d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qH9EWZvTrPNMSL/V"
Content-Disposition: inline
In-Reply-To: <d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
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

--qH9EWZvTrPNMSL/V
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 10:58:42AM +0300, Samuli Sepp=E4nen wrote:
> I stand corrected. However, cross-building is not a replacement for=20
> building on the actual OS.
>=20
> Do cross-builds generally catch useful issues, or do they tend to catch=20
> issues related to the cross-building environment itself?

The mingw builds that you run have caught quite a few commits with
unexpected side effects (header files not right for windows, and such
stuff) - so they are definitely useful.

Occasionaly, they catch "building environment bugs", which is annoying,
but easier than setting up windows build environments...

What is missing with the cross-builds is to be able to *run* the binary
to do full-binary tests (and, obviously, unit tests also do not work with
cross-built stuff).  So it's not as good as automated local builds with
test suite, but until we can have that for windows, I'm happy with mingw=20
cross-builds and automatically uploaded snapshots for all commits :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qH9EWZvTrPNMSL/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1aEa6kuBuNlUUl1AQJHugQAt4KdVgrjIUkyNrQvD4fc8qp/Gl2672N0
BT9Uyv/qNPyENWSuU4UfCTRr+DOebSodeKuv7mAXTH1Fjyz+G3Ly5VdvQ6p6qE6/
ifEzomIfjP3srQn8K63k4P5OtT+qNcjxNe4olEh7vu9pwoZW7tfHNZdCyl6Tcfx9
BBqhe6dklUI=
=DXZ6
-----END PGP SIGNATURE-----

--qH9EWZvTrPNMSL/V--

