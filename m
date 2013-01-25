Date: Fri, 25 Jan 2013 10:00:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130125090042.GM22465@...1296...>
References: <1359101540-976-1-git-send-email-samuli@...515...>
	<1359101540-976-5-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OO26Ec7kKr0HQ07l"
Content-Disposition: inline
In-Reply-To: <1359101540-976-5-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] Cleaned up and updated INSTALL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

--OO26Ec7kKr0HQ07l
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 25, 2013 at 10:12:20AM +0200, samuli@...515... wrote:
> From: Samuli Sepp=E4nen <samuli@...515...>
>=20
> - Changed "Supported platforms" to reflect current support status of the
>   mentioned operatingsystems
> - Removed mentions of the obsolete Python and domake-win buildsystems
> - Added mention of official Debian/RPM packages
> - Added links to the Wiki
> - Added mention of the new openvpn-build cross-compile environment
> - Added PolarSSL to and removed pthreads from the "Optional" section
> - Added mention of t_client.sh test framework
> - Removed some very old (pre-2005) nuggets of (obsolete) information
> - Other minor cleanups
> - Some reorganization

Mostly ACK, except for a small imission:

> +* Windows XP/2003/Vista/7:
>=20=20
> - See the man page for more information, usage examples, and
> - information on firewall configuration.
> +  OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN inst=
allers
> +  include this driver, so installing it separately is not usually requir=
ed.=20
> +  The driver source code is available here:
>=20=20
>  *************************************************************************

... the info about the driver source was lost, it seems - it says=20
"is available here:" and then the section ends...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OO26Ec7kKr0HQ07l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUQJJuqkuBuNlUUl1AQIxaAP/ap9JJs339Aug+stWUTlLbh5xfSzSokyD
QxfUMT+q2B4OYybUw7xXckLDGpG2WUdfAHxRawJYCvcVGFHLGb243qaAZE9pQ1WR
U3YJk4acGjK70xdXezVZQEZndP9Sv8OPSpp9BSHmAHLnwkuklJmuE0LDToqhgTvX
yGkAx1j/bH0=
=aCd5
-----END PGP SIGNATURE-----

--OO26Ec7kKr0HQ07l--

