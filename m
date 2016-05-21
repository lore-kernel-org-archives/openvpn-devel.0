Date: Sat, 21 May 2016 20:59:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160521185940.GT53051@...1296...>
References: <AE97EF71-3179-4CA9-859C-EE9F2A5DEFBA@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="59HVkO/7xZ5pt6CE"
Content-Disposition: inline
In-Reply-To: <AE97EF71-3179-4CA9-859C-EE9F2A5DEFBA@...2127...>
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--59HVkO/7xZ5pt6CE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 21, 2016 at 07:05:01PM +0200, Jens Neuhalfen wrote:
> ./t_lpback.sh fails with AES-GCM mode on Solaris 11. CRYPTO_gcm128_setiv =
from libcrypto seems to jump into NULL pointer country.=20

Oh, interesting.  My OpenSSL on the OpenSolaris box is so old that it does
not have the AES-GCM modes, so I never tested this (and, of course, "all=20
tests pass").

Is this Sparc or Intel Solaris?  Which version of OpenSSL?  32 or 64 bit?

I tried building with 1.0.2g (static libraries, 32 bit) and that actually
passes GCM tests for me...

-n Testing cipher AES-128-CBC...=20
OK
-n Testing cipher AES-128-CFB...=20
OK
-n Testing cipher AES-128-CFB1...=20
OK
-n Testing cipher AES-128-CFB8...=20
OK
-n Testing cipher AES-128-GCM...=20
OK
...
OK
-n Testing cipher AES-256-CFB8...=20
OK
-n Testing cipher AES-256-GCM...=20
OK
-n Testing cipher AES-256-OFB...=20
OK
...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
All 2 tests passed
(1 tests were not run)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


OpenVPN 2.PRODUCT_VERSION_MINORPRODUCT_VERSION_PATCH [git:master/a9faebe7d4=
234cdf+] i386-pc-solaris2.11 [SSL (OpenSSL)] [LZO] [LZ4] [IPv6] built on Ma=
y 21 2016
library versions: OpenSSL 1.0.2g  1 Mar 2016, LZO 2.03


... so at this point, it's hard to say...=20

gert

PS: and yes, our test scripts and Solaris' "echo" function do not like
each other very much.  And neither does the script that builds the version
number from git :-)
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--59HVkO/7xZ5pt6CE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0CwHKkuBuNlUUl1AQKfXgP/Teap1subKTxWjCEP0Gh96ESfwObxBmBO
ftWJ+IQNZ5hBrFvbVBbTrU73vucie3HM97qhRQSONfcay25BQxBja4U7rRZxHWdc
a0ngDoLsp+t1P87ittl8cyXuX1wv6XI1xZAWl66nxfCPu/9wTQ4Whd328Hz5xKzc
o2Y+dCXa2UA=
=wVvb
-----END PGP SIGNATURE-----

--59HVkO/7xZ5pt6CE--

