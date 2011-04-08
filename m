Date: Fri, 8 Apr 2011 17:45:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110408154548.GX8496@...1296...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
	<1302262805-23686-3-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCKkSrrNUaKEhaIQ"
Content-Disposition: inline
In-Reply-To: <1302262805-23686-3-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Use %SystemRoot% instead of
	hard-coded C:\WINDOWS for temp directory path
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

--lCKkSrrNUaKEhaIQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 08, 2011 at 01:40:05PM +0200, David Sommerseth wrote:
> It is expected that %SystemRoot% is always defined to the directory of the
> Windows system.  If this is undefined, Windows do not work properly.
>=20
> So instead of hard-coding C:\WINDOWS\Temp as the default temporary direct=
ory
> if %TEMP% or %TMP% is not found, use %SystemRoot%\Temp instead as the fal=
lback.

ACK in principle, but

> +    return NULL; /* Just in case M_FATAL doesn't exit() */

NACK on this.=20=20

We don't do this anywhere else where msg(M_FATAL) is called either - because
we know it won't return.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lCKkSrrNUaKEhaIQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTZ8trKkuBuNlUUl1AQLzEQP8DZZBkKYjzDiIAFDJ46K/r1PUcxadsKx1
GoON7G/Xf2ncRlLxCweKCeZMeqhonhakbALMHtE+aQuY3Cya6cBqf9pXzFgfLLAi
ZC6+vE3MXAHeK0vKL95SdzisUaLTmTBzaAcqF/tLDkuKRDbFVx7NjtIdzyckwHzs
tSF3z4ucz2k=
=plW1
-----END PGP SIGNATURE-----

--lCKkSrrNUaKEhaIQ--

