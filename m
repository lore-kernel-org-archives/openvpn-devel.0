Date: Tue, 31 May 2016 16:35:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531143533.GY53051@...1296...>
References: <1464690813-10411-1-git-send-email-openvpn@...2080...>
	<1464703645-26640-1-git-send-email-openvpn@...2080...>
	<20160531142322.GW53051@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YVrlT4vedgQKZ0IS"
Content-Disposition: inline
In-Reply-To: <20160531142322.GW53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Only build and run cmocka unit tests
 if its submodule is initialized
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...2145...>

--YVrlT4vedgQKZ0IS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2016 at 04:23:22PM +0200, Gert Doering wrote:
> On Tue, May 31, 2016 at 04:07:25PM +0200, David Sommerseth wrote:
> > +   AC_MSG_RESULT([!! WARNING !! CMake is available.  Unit testing cann=
ot be performed.])
>=20
> NAK, as this should be "CMake is NOT available" - otherwise, I would be
> happy to ACK it :-)

For the sake of the archives: ACK for "v2 + that typo" :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--YVrlT4vedgQKZ0IS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV02hJqkuBuNlUUl1AQLUgQQAiFZDrR6FWvhPuYzyNjZytUVR3WsNknCA
9Jiw36jsN0uauNYD+0g2tkFANFRhL9o2T17mW29FeVAFG6qI9a8rq1E5fFz/V6vp
/ZlvVatNznLsx+ELVxUmKEsrOSoDTCNU3ell2K67MU9DSQcPjC1LugRhSikB1Zu2
GqXNN+8298s=
=UBL1
-----END PGP SIGNATURE-----

--YVrlT4vedgQKZ0IS--

