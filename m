Date: Fri, 3 Jun 2016 08:46:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160603064614.GF53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JGY7j44T2CBDTV/X"
Content-Disposition: inline
In-Reply-To: <1464883738-904-1-git-send-email-openvpn@...2080...>
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
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...2145...>

--JGY7j44T2CBDTV/X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 02, 2016 at 06:08:58PM +0200, David Sommerseth wrote:
>  if CMOCKA_INITIALIZED
> +	mkdir -p $(cmockabuild) $(cmockainstall)

This will still blow up if the source or build directory contain whitespace
- if absolute paths outside Makefile's control are used, they must be=20
quoted.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JGY7j44T2CBDTV/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1EntqkuBuNlUUl1AQLIfQP/aNudWbxTbR5yhmm1qV8iK5pTDYAO8aa1
tUSD3OAlb9rf8FfhWWJ/IKEPHGBO0tA9JN1d+LT0n2b/oUYpu6efemSKSCDotokA
+QTPBJs/BZtS5kpQuGvNTSa97HWgujJqAD+JZXleJPgGtDp8Yrz/CHoDuswEmXjB
m2b6C5joJW8=
=IUod
-----END PGP SIGNATURE-----

--JGY7j44T2CBDTV/X--

