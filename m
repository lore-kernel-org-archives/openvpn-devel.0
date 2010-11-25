Message-ID: <4CEEC09A.9080804@...515...>
Date: Thu, 25 Nov 2010 22:01:30 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000006000700040303070403"
Subject: [Openvpn-devel] [PATCH] Fixed an issue causing a build failure with
 MS Visual Studio 2008
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000006000700040303070403
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit



--------------000006000700040303070403
Content-Type: text/x-patch;
	name="0001-Fixed-an-issue-causing-a-build-failure-with-MS-Visua.patch"
Content-Disposition: inline;
	filename*0="0001-Fixed-an-issue-causing-a-build-failure-with-MS-Visua.pa";
	filename*1="tch"
Content-Transfer-Encoding: quoted-printable

From 36baafa15e414ab37823160801eaa340171563aa Mon Sep 17 00:00:00 2001
From: =3D?utf-8?q?Samuli=3D20Sepp=3DC3=3DA4nen?=3D <samuli@...515...>
Date: Thu, 25 Nov 2010 21:48:34 +0200
Subject: [PATCH] Fixed an issue causing a build failure with MS Visual St=
udio 2008.
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

The new SOCKS auth code in socks.c contained a call to sprintf instead of
openvpn_sprintf. This caused build to fail if MS Visual Studio 2008 C com=
piler
was used. This change fixes that issue.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 socks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/socks.c b/socks.c
index 1848f08..8287274 100644
--- a/socks.c
+++ b/socks.c
@@ -121,7 +121,7 @@ socks_username_password_auth (struct socks_proxy_info=
 *p,
                "Authentication not possible.");
           return false;
   }
-  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(cred=
s.username),
+  openvpn_snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) str=
len(creds.username),
             creds.username, (int) strlen(creds.password), creds.password=
);
   size =3D send (sd, to_send, strlen(to_send), MSG_NOSIGNAL);
=20
--=20
1.6.3.3


--------------000006000700040303070403--

