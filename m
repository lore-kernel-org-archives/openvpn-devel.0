Message-ID: <4CFA2341.3080905@...68...>
Date: Sat, 04 Dec 2010 12:17:21 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4CF90B25.3010104@...515...>	<20101204025529.GA3200@...33...>
	<4CFA1A01.2000602@...515...>
In-Reply-To: <4CFA1A01.2000602@...515...>
Content-Type: multipart/mixed; boundary="------------070100040601070200090002"
Subject: Re: [Openvpn-devel] Error C2010 in openvpnserv.c during VS2008 build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070100040601070200090002
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 04.12.2010 11:37, schrieb Samuli Sepp=E4nen:
> Hi Matthias,
>=20
> Your patch fixes the issue.

Hi Samuli,

then please use the attached /updated/ patch (same code, different log entr=
y).
It fixes VS2008, and breaks compatibility with GCC before 3.0.

For the records, it was discussed on IRC with David Sommerseth and yourself=
 on
2010-12-04 around 11:08 UTC that we deem it unnecessary to keep GCC < 3.0
compatibility for this new Windows-only code.

Best

--=20
Matthias Andree

--------------070100040601070200090002
Content-Type: text/x-diff;
	name="0001-Change-variadic-macros-to-C99-style.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-Change-variadic-macros-to-C99-style.patch"

From 0374c641d4086dfea91bd64c22bb5280bbddf346 Mon Sep 17 00:00:00 2001
From: Matthias Andree <matthias.andree@...68...>
Date: Sat, 4 Dec 2010 03:51:11 +0100
Subject: [PATCH] Change variadic macros to C99 style.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macros used GCC's pre-C99 syntax, which could not be compiled with
Microsoft Visual Studio 2008.

Note this breaks compatibility with GCC versions before 3.0, which is
deemed safe in a discussion on IRC with David Sommerseth and Samuli
Sepp��nen on #openvpn-devel (RHEL 3 uses GCC 3.2 already).

Compiled tested on VS2008 by Samuli, on Cygwin GCC 3.4 and GCC 4.3 by myself.

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 service-win32/openvpnserv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/service-win32/openvpnserv.c b/service-win32/openvpnserv.c
index 6c9ff1e..07374e2 100755
--- a/service-win32/openvpnserv.c
+++ b/service-win32/openvpnserv.c
@@ -84,9 +84,9 @@ static HANDLE exit_event = NULL;
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
 
 /* snprintf with guaranteed null termination */
-#define mysnprintf(out, args...) \
+#define mysnprintf(out, ...) \
         { \
-           snprintf (out, sizeof(out), args); \
+           snprintf (out, sizeof(out), __VA_ARGS__); \
            out [sizeof (out) - 1] = '\0'; \
         }
 
@@ -98,10 +98,10 @@ static HANDLE exit_event = NULL;
 #define M_ERR     (MSG_FLAGS_ERROR)                    // error
 
 /* write error to event log */
-#define MSG(flags, args...) \
+#define MSG(flags, ...) \
         { \
            char x_msg[256]; \
-           mysnprintf (x_msg, args); \
+           mysnprintf (x_msg, __VA_ARGS__); \
            AddToMessageLog ((flags), x_msg); \
         }
 
-- 
1.7.3.2.438.g94fdb6


--------------070100040601070200090002--

