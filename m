Date: Thu, 11 Feb 2016 09:59:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160211085953.GI24952@...1296...>
References: <56B86D5C.5070506@...515...> <20160211082842.GD2461@...1281...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yHNGbMC0MI9av46F"
Content-Disposition: inline
In-Reply-To: <20160211082842.GD2461@...1281...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yHNGbMC0MI9av46F
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 11, 2016 at 10:28:42AM +0200, Pasi K=E4rkk=E4inen wrote:
> Do you know if it's now possible to have also the OpenVPN config files an=
d certs in user's profile directory
> (not on system-wide c:\windows\program files\openvpn\config\) ?=20

The intention is to make this configurable at installation time ("only
admin-provided openvpn profiles" vs. "user-installable profiles").

Details to be solved.

(Background: if you permit user configs for unprivileged users, you permit
unprivileged users to mess with routing, and potentially "steal traffic"
by redirecting traffic into a malicious VPN server - so this needs to be
a conscious decision by the admin at installation time)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yHNGbMC0MI9av46F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrxNiKkuBuNlUUl1AQLHOwQAsXr2FWO1w+ZJKCqLn9u+pVT+jV9bm2Nx
PNwXXlYRdt1skEbfjssZumhfK26PK8Fph2MC0bifoOulbP+AhLSCkruOww6n5UMX
jugD4xwV5m5itTXgzOeJHioGByDk6m91X4C+j9uo67jkClbxmemIIIcsJmh8edyp
DMzag2TPVDk=
=UAZw
-----END PGP SIGNATURE-----

--yHNGbMC0MI9av46F--

