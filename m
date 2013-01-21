Date: Mon, 21 Jan 2013 21:23:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130121202321.GH22465@...1296...>
References: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
	<1358774007-4881-2-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sUe7wZq11KQldpsm"
Content-Disposition: inline
In-Reply-To: <1358774007-4881-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve PolarSSL
	key_state_read_{cipher, plain}text messages
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

--sUe7wZq11KQldpsm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 21, 2013 at 02:13:25PM +0100, steffan.karger@...1435... wrote:
> +#ifdef POLARSSL_ERROR_C
> +  char error_message[1024];
> +#endif

What condition does that #ifdef depend on?  Will this function not always
be available in Polar 1.2.3 and up?

"We're trying to get rid of #ifdefs, not add more"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sUe7wZq11KQldpsm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUP2juakuBuNlUUl1AQLuXAP/db9esl5kkYlOEex1PQ1CuafRG8VPc8gq
7BUgbrItG87TbxHVowUAbWnyvybZnOVQWO7BJK6/MlVMEKrxLlYp6+TzPcLeEZSy
Y8MegiaB6N2oLf8fuur31G42m/cO3bHQPpbq6Nj43cYA0BMlWXGNqi3LA/a/oeYB
4uT0gY6gP8Y=
=1hoZ
-----END PGP SIGNATURE-----

--sUe7wZq11KQldpsm--

