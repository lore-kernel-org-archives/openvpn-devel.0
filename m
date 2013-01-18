Date: Fri, 18 Jan 2013 22:22:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130118212232.GZ22465@...1296...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-4-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzBafMtx5eI/BDwD"
Content-Disposition: inline
In-Reply-To: <1358411009-2350-4-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

--MzBafMtx5eI/BDwD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 17, 2013 at 09:23:29AM +0100, steffan.karger@...1435... wrote:
>  /** Cipher is in CFB mode */
> +#if POLARSSL_VERSION_NUMBER < 0x01020000
>  #define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB128
> +#else
> +#define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB
> +#endif

I don't like this approach - we have way too many #ifdef's already.

Is there any benefit in keeping support for PolarSSL 1.1, given that
it's not interoperable with OpenVPN's default crypto settings (blowfish)?


So unless there are strong reasons to support both 1.1 and 1.2, I'd
just move over to 1.2, document the requirement "anything before 1.2.3
is not supported, period" and declare 1.1 historic...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MzBafMtx5eI/BDwD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUPm9GKkuBuNlUUl1AQIqagP/TfpIhPs+jujKqYSDmzjoZIs/+aEnm3Dj
H3ihmjbTUPNmX7tUXSyVRB2PqonGgvIamcbmlx92lcj398sGIuw9h1VmmY+TsyC9
U3eTdnlu8kC8vFuSOXtC60TElpK7mXYY2WhrRLzTfjVqDmfilr1cqEEjCHmu8iix
n4zh4HzOR2w=
=kl30
-----END PGP SIGNATURE-----

--MzBafMtx5eI/BDwD--

