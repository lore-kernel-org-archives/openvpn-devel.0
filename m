Message-ID: <4D24703E.70504@...515...>
Date: Wed, 05 Jan 2011 15:21:02 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060004010207030002080208"
Subject: [Openvpn-devel] [PATCH] Changed snprintf to _snprintf in
	service-win32/openvpnserv.c
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
--------------060004010207030002080208
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

This fixes a generic Windows/VC++ issue:

<http://thedailyreviewer.com/dotnet/view/strncasecmp-and-snprintf-functions=
-not-available-in-vc-109235975>

Does this change affect the automake/gcc-based Windows builds?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------060004010207030002080208
Content-Type: text/x-patch;
	name="0001-Changed-snprintf-to-_snprintf-in-service-win32-openv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-Changed-snprintf-to-_snprintf-in-service-win32-openv.pa";
	filename*1="tch"

From 96880655ebfc1859d18431eeecc9103d29951935 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Wed, 5 Jan 2011 15:14:21 +0200
Subject: [PATCH] Changed snprintf to _snprintf in service-win32/openvpnserv.c

This solves a fatal build error (LNK2019: unresolved external symbol _snprintf
referenced...) when using the Python-based build system
---
 service-win32/openvpnserv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/service-win32/openvpnserv.c b/service-win32/openvpnserv.c
index 07374e2..42be609 100755
--- a/service-win32/openvpnserv.c
+++ b/service-win32/openvpnserv.c
@@ -86,7 +86,7 @@ static HANDLE exit_event = NULL;
 /* snprintf with guaranteed null termination */
 #define mysnprintf(out, ...) \
         { \
-           snprintf (out, sizeof(out), __VA_ARGS__); \
+           _snprintf (out, sizeof(out), __VA_ARGS__); \
            out [sizeof (out) - 1] = '\0'; \
         }
 
-- 
1.6.3.3


--------------060004010207030002080208--

