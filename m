Date: Sun, 13 Apr 2014 14:56:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413125641.GQ16637@...1296...>
References: <20140409232527.GA3061@...1890...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VaFRWuBqemT1wauK"
Content-Disposition: inline
In-Reply-To: <20140409232527.GA3061@...1890...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cedric <cedric+openvpn@...1891...>
Cc: openvpn-devel@lists.sourceforge.net

--VaFRWuBqemT1wauK
Content-Type: multipart/mixed; boundary="H9lV7n9R6VhQg+4w"
Content-Disposition: inline

--H9lV7n9R6VhQg+4w
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

On Thu, Apr 10, 2014 at 01:25:27AM +0200, Cedric wrote:
> I get an error on latest release 2.3.3 (and previous ones), on windows 8.=
1.
>=20
> NETSH: C:\WINDOWS\system32\netsh.exe interface ipv6 delete address OPENVP=
N 2a02:xxxx:xxxx:ffff::1000

So.  here we go :-)

Patch (for 2.3.3, but should apply as well to master) is appended.

Windows installers for x32 and x64 can be found here:

  http://www.greenie.net/ipv6/openvpn-install-2.3.3-routefix-I099-i686.exe
  http://www.greenie.net/ipv6/openvpn-install-2.3.3-routefix-I099-x86_64.exe

Please test, and report if that fixes it for you.

The sources in there are "pristine 2.3.3 plus the appended patch", built
with pkcs11-helper 1.11 and openssl 1.0.1g.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H9lV7n9R6VhQg+4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-IPv6-route-delete-fix-for-Win8.patch"
Content-Transfer-Encoding: quoted-printable

=46rom fce0349d035b77e738cb19856d05d92f8cc907bd Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 13 Apr 2014 13:12:02 +0200
Subject: [PATCH] IPv6 route delete fix for Win8

Use "store=3Dactive" for IPv6 route deletion as well - seems to be required
on Windows 8 and up, and will break OpenVPN reconnection, as old routes
are not properly deleted, thus new routes cannot be added.

Reported-by: Cedric <cedric+openvpn@...1891...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6333ee7..78d9c83 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1974,10 +1974,16 @@ delete_route_ipv6 (const struct route_ipv6 *r6, con=
st struct tuntap *tt, unsigne
     argv_printf_cat (&argv, "METRIC %d", r->metric);
 #endif
=20
+  /* Windows XP to 7 "just delete" routes, wherever they came from, but
+   * in Windows 8(.1?), if you create them with "store=3Dactive", this is
+   * how you have to delete them as well (pointed out by Cedric)
+   */
+  argv_printf_cat( &argv, " store=3Dactive" );
+
   argv_msg (D_ROUTE, &argv);
=20
   netcmd_semaphore_lock ();
-  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add ipv6 comma=
nd failed");
+  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete ipv6 co=
mmand failed");
   netcmd_semaphore_release ();
=20
 #elif defined (TARGET_SOLARIS)
--=20
1.8.3.2


--H9lV7n9R6VhQg+4w--

--VaFRWuBqemT1wauK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0qJiakuBuNlUUl1AQLi9gQAwZmtgIorXeQWZEsy52op2BYKh9wKl12j
BPKN230/QeeC5MV93QS0gLRhNHhb8SeXZi3MyXUjCHZq7EsPiMP0Wq5ZhaVtSB6j
QYtOD0vAV/DRMvLIWLRy+yrXeUEuPwN4adKZfCieCNsBVqlUUygF8EkAkqvqCgHZ
0rND73HTODQ=
=5iBN
-----END PGP SIGNATURE-----

--VaFRWuBqemT1wauK--

