Sender: Peter Korsgaard <jacmet@...277...>
From: Peter Korsgaard <jacmet@...1406...>
Date: Thu, 23 Sep 2010 22:09:06 +0200
Message-ID: <87fwx08bod.fsf@...1407...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix build with --disable-crypto
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: crossdev@...1408...

options.c is missing the definition for struct context when built with
--disable-crypto, as it then doesn't get pulled in through push.h,
leading to build errors like:

options.c: In function =E2=80=98parse_http_proxy_fallback=E2=80=99:
options.c:1474: error: dereferencing pointer to incomplete type
options.c:1477: error: dereferencing pointer to incomplete type
options.c:1478: error: dereferencing pointer to incomplete type

Fix it by including forward.h

Signed-off-by: Peter Korsgaard <jacmet@...1406...>
---
 options.c |    1 +
 1 file changed, 1 insertion(+)

Index: openvpn-2.1.3/options.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- openvpn-2.1.3.orig/options.c
+++ openvpn-2.1.3/options.c
@@ -29,6 +29,7 @@
=20
 #include "syshead.h"
=20
+#include "forward.h"
 #include "buffer.h"
 #include "error.h"
 #include "common.h"

--=20
Bye, Peter Korsgaard

