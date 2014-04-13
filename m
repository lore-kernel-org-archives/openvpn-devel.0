Date: Sun, 13 Apr 2014 15:01:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413130102.GR16637@...1296...>
References: <1397389435-20170-1-git-send-email-gert@...1296...>
	<20140413115257.GO16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6r23r+Dq74Mmab2T"
Content-Disposition: inline
In-Reply-To: <20140413115257.GO16637@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix SOCKSv5 method selection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Yawning Angel <yawning@...1897...>

--6r23r+Dq74Mmab2T
Content-Type: multipart/mixed; boundary="EzHKMnyyhfYPP6XQ"
Content-Disposition: inline

--EzHKMnyyhfYPP6XQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 01:52:57PM +0200, Gert Doering wrote:
> I'll amend that when committing.

Here is the patch with the MSVC build change, plus some changes to the
commit message to point to the pull request and trac.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EzHKMnyyhfYPP6XQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-SOCKSv5-method-selection.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 19b662a2013769f62bcd4e8776a63641e3fb991d Mon Sep 17 00:00:00 2001
From: Yawning Angel <yawning@...1897...>
Date: Mon, 10 Mar 2014 03:47:58 +0000
Subject: [PATCH] Fix SOCKSv5 method selection

So, RFC 1928 doesn't say anything about the METHODS field in the Method
Selection message being ordered in terms of preference or anything, and
the server is free to pick any of the METHODS offered by the client.

Always sending a Method Selection message with NO AUTHENTICATION REQUIRED
and USERNAME/PASSWORD set is broken on two fronts:

 * If the OpenVPN client can't handle the server picking USERNAME/PASSWORD
   due to the credentials being missing, it shouldn't offer it to the serve=
r.

 * If the OpenVPN client has credentials, then it should always attempt to
   authenticate.  This is a security product.  "You can misconfigure it and
   it will work" is not acceptable.  Setting a username/password when the
   SOCKS server doesn't require/support that as an option is the user not
   configuring it correctly, and should be treated as such.

Also verify that the SOCKS server returned the auth that was requested.

URL: https://github.com/OpenVPN/openvpn/pull/14
Fix trac #377
---
 src/openvpn/socks.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 1551da8..ee746a3 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -189,10 +189,15 @@ socks_handshake (struct socks_proxy_info *p,
   char buf[2];
   int len =3D 0;
   const int timeout_sec =3D 5;
+  const ssize_t size;
=20
-  /* VER =3D 5, NMETHODS =3D 2, METHODS =3D [0 (no auth), 2 (plain login)]=
 */
-  const ssize_t size =3D send (sd, "\x05\x02\x00\x02", 4, MSG_NOSIGNAL);
-  if (size !=3D 4)
+  /* VER =3D 5, NMETHODS =3D 1, METHODS =3D [0 (no auth)] */
+  char method_sel[3] =3D { 0x05, 0x01, 0x00 };
+  if (p->authfile[0])
+      method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */
+
+  size =3D send (sd, method_sel, sizeof (method_sel), MSG_NOSIGNAL);
+  if (size !=3D sizeof (method_sel))
     {
       msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write faile=
d on send()");
       return false;
@@ -252,6 +257,13 @@ socks_handshake (struct socks_proxy_info *p,
       return false;
     }
=20
+  /* validate that the auth method returned is the one sent */
+  if (buf[1] !=3D method_sel[2])
+    {
+      msg (D_LINK_ERRORS, "socks_handshake: Socks proxy returned unexpecte=
d auth");
+      return false;
+    }
+
   /* select the appropriate authentication method */
   switch (buf[1])
     {
--=20
1.8.3.2


--EzHKMnyyhfYPP6XQ--

--6r23r+Dq74Mmab2T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0qKjqkuBuNlUUl1AQKFSQQAip34sglbI8t+KFcCsGanKMcCec/f1cXi
vrTu3V5YBS8n8itZ2/w1Nm4DOPFM/1hhydZXNeDR6wOaDZz5ogewMSDBYrM/0Atv
Q3gnGPSr97NwbVlXTlc4e1frlKPh5cPHXzj9wnF7usyhwqgRpUbczRYr+12y9YTE
D/mdf3hhBF0=
=QlOG
-----END PGP SIGNATURE-----

--6r23r+Dq74Mmab2T--

