Date: Tue, 31 May 2011 18:24:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110531162439.GA4164@...1296...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
	<1306416185-4901-3-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <1306416185-4901-3-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Fix Microsoft Visual Studio
	incompatibility in plugin.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 26, 2011 at 04:23:03PM +0300, Samuli Sepp=E4nen wrote:
> MS Visual Studio don't like to have struct members named in the
> variable declaration.  Without this fix, Visual Studio is not able
> to compile the new v3 plug-in API.

ACK.  Looks reasonable (what I've checked is: make sure that the variables
in question are in the order that the structure expect it - which the=20
compiler can't sort out for you if it doesn't understand the new format
of specifying struct inits).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTeUWR6kuBuNlUUl1AQKhcwP/Vig5O8V644AiPPyXbPHVwi1BeLCoY/3s
eYPmEnYPrL+zEz2HiyZKPLRV8g2c0r6gM+pF4cQdDRpKDqqjSToaL7iDqQfnQNPB
yqUY/h90SIAz7xVhLkfgbb7PxAYOo5e5ou3G7mOlin3LGFE0CJXaQvfSF9MZO6vQ
aajxCzl9XZ8=
=QpYU
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

