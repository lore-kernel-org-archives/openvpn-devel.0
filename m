Date: Thu, 26 Apr 2012 14:54:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120426125431.GP1359@...1296...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uh+mCrJpyFMxfp6S"
Content-Disposition: inline
In-Reply-To: <1335441085-18186-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
	capable at build time
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

--Uh+mCrJpyFMxfp6S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 26, 2012 at 01:51:25PM +0200, David Sommerseth wrote:
> These days it is highly unlikely that OpenVPN will be built in a non-IPv6
> capable Linux environment.  So remove compile-time related macros identif=
ying
> that.
>=20
> This also solves an issue which was introduced in commit 51bd56f46f55177c=
f0f8b
> where HAVE_TUN_PI and HAVE_IPHDR is no longer detected.  As these macros =
where
> only used to detect if IPv6 support was available on Linux, it makes no s=
ense
> looking for them any more.

ACK.  What he said.

(I'm don't particularily insist on the configure.ac change if that turns
out to be controversial - but the tun.c change really removes old cruft
that should have gone away years ago :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Uh+mCrJpyFMxfp6S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5lFh6kuBuNlUUl1AQKfnAP/YqdbZVIur4n6nQTyTQMr/GotiwbRqS49
UmKEaYIw5gaBW+SlxSIHhXrLgAf+PhV6BlOTswFf+Tp4ix8dudy7IGsYDc42UEgC
4Of5MPfw9rElWEZ27huBi6I4EeIf6uJyavmHhI9Td4hH6So0UmSAlm2PJz0kXj6h
kUvGPOm4xTU=
=9Mia
-----END PGP SIGNATURE-----

--Uh+mCrJpyFMxfp6S--

