Date: Fri, 8 Apr 2011 17:41:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110408154136.GW8496@...1296...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
	<1302262805-23686-2-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9uazBBczf8QSjDPd"
Content-Disposition: inline
In-Reply-To: <1302262805-23686-2-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Make use of $TMPDIR on non-Windows
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

--9uazBBczf8QSjDPd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 08, 2011 at 01:40:04PM +0200, David Sommerseth wrote:
> According to the Single Unix Specification (SuS) [1] the $TMPDIR environm=
ent
> variable may define another temporary directory than the standard /tmp
> directory.  As it is considered safe to assume /tmp will always exist, re=
move
> the possibility to change this at compile time.

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9uazBBczf8QSjDPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTZ8ssKkuBuNlUUl1AQJ1iwP+Ie0rbyGBAsaVp2FsqPgLR4bsnF65tOVS
sRbml4+XLzV3N4AIgWXR4qKNzR6dz6MfObSDhs2Tstf/RnJI1jGw7n2XVn5ygQs1
X7r+QaaQfNaUfd0rPcYobKf5OaPxLxXsOQGchEgpWVDqoHJDBnta9/HKFthrrawP
70fWjQhyxog=
=MTOg
-----END PGP SIGNATURE-----

--9uazBBczf8QSjDPd--

