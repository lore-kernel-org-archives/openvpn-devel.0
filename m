Message-ID: <548D9046.5000600@...1856...>
Date: Sun, 14 Dec 2014 14:27:34 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <2215306.x9ci9DhAZ9@...2001...>
In-Reply-To: <2215306.x9ci9DhAZ9@...2001...>
Content-Type: multipart/mixed; boundary="------------000709070807010109060107"
Subject: Re: [Openvpn-devel] Make OpenVPN set routes on Windows Vista and
 later
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
--------------000709070807010109060107
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On 16-11-14 13:51, Heiko Hund wrote:
> Please review and comment.

This morning I finally found some time to set up a windows build
environment to cross-compile the windows builds from linux. I'm trying
to find more time to really review and test. For now just some
preliminary stuff I came across:

(1) open_tun(), close_tun(), etc :
Instead of passing the options struct, consider just passing the
msg_channel. That would require it to be something more generic than
HANDLE, but I think this model makes sense for other platforms too.

(2) includes: you should include "openvpn-msg.h", instead of
"include/openvpn-msg.h" (that's how it's done for openvpn-plugin.h too):

openvpn/src/openvpn/route.c:48:33: fatal error: include/openvpn-msg.h:
No such file or directory
 #include "include/openvpn-msg.h"

Attached a patch with the changes I had to make.

(3) mingw/GCC has a warning for me:

openvpn/src/openvpnserv/interactive.c:708:11: warning: enumeration value
=91_undo_type_max=92 not handled in switch [-Wswitch]
           switch (type)
           ^

For others: if you have Windows build and test setups, please help out.
Especially Windows users willing to test are welcome. This feature
deserves more attention :)

-Steffan

--------------000709070807010109060107
Content-Type: text/x-patch;
 name="0001-Fix-openvpn-msg.h-includes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Fix-openvpn-msg.h-includes.patch"

=46rom 1fa191c9edfdef1b22dc04b789162a275cc507ef Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 14 Dec 2014 14:12:42 +0100
Subject: [PATCH] Fix openvpn-msg.h includes

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/route.c           | 2 +-
 src/openvpn/tun.c             | 2 +-
 src/openvpnserv/Makefile.am   | 3 +++
 src/openvpnserv/interactive.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6d7e8e2..55ab11e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -45,7 +45,7 @@
=20
 #include "memdbg.h"
=20
-#include "include/openvpn-msg.h"
+#include "openvpn-msg.h"
=20
 #ifdef WIN32
 #define METRIC_NOT_USED ((DWORD)-1)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9b2fa1a..0b629fa 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -50,7 +50,7 @@
=20
 #include "memdbg.h"
=20
-#include "include/openvpn-msg.h"
+#include "openvpn-msg.h"
=20
 #include <string.h>
=20
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 6088287..4bb1c27 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -17,6 +17,9 @@ EXTRA_DIST =3D \
 	openvpnserv.vcxproj \
 	openvpnserv.vcxproj.filters
=20
+AM_CPPFLAGS =3D \
+	-I$(top_srcdir)/include
+
 if WIN32
 sbin_PROGRAMS =3D openvpnserv
 openvpnserv_CFLAGS =3D \
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.=
c
index 368450b..0040d85 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -34,7 +34,7 @@
 #include <stdio.h>
 #include <sddl.h>
=20
-#include "include/openvpn-msg.h"
+#include "openvpn-msg.h"
=20
 #define IO_TIMEOUT  2000 /*ms*/
=20
--=20
1.9.1


--------------000709070807010109060107--

