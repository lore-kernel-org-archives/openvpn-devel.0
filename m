Date: Tue, 17 Jul 2012 17:55:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120717155541.GW22125@...1296...>
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EUYUPHVNfBVWjsvu"
Content-Disposition: inline
In-Reply-To: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] don't treat socket related errors
	special anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--EUYUPHVNfBVWjsvu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 17, 2012 at 03:57:52PM +0200, Heiko Hund wrote:
> WSAGetLastError() is just a wrapper for GetLastError(). So, there's
> no need to differentiate between socket related and other errors.

ACK.

Earlier versions of Windows handled winsock stuff differently, but
Heiko checked WinXP for me, and that also has a wrapper - so we only
lose platforms that we do not support anymore anyway in 2.3, and=20
if it cleans up our code, that is good.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EUYUPHVNfBVWjsvu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAWK/KkuBuNlUUl1AQJx2wQAvZz6/fTKsW73gxQHLcNMMmn1Q5BNiKCc
ftwxgWW6zEXH/EbUv1CWvCJknOJARhinVzKYVO02JECp7IICfMN419pxROSZh4dt
geTfU9AE6FRYJvqU0pHyfT7a/L/nIhzB8qpHWT5bJwlaJsmZ4VSY8n7Mxoy7wYHX
eEibJ+pYqOA=
=lrqW
-----END PGP SIGNATURE-----

--EUYUPHVNfBVWjsvu--

