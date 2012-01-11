From: David Sommerseth <davids@...1347...>
Date: Wed, 11 Jan 2012 14:57:32 +0100
Message-Id: <1326290252-25076-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] autotools ./configure don't like compat.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: dazo@...1345...

The compat.h include file cannot be loaded when ./configure runs,
as many of the HAVE_* declarations are not set.  This makes test
compilations when looking for features fail.

As ./configure will load syshead.h, it pulls in compat.h this way.
Looking more carefully at syshead.h, there's a #ifndef PACKAGE_NAME
check if config.h should be included.  This looks like a check if
syshead.h is loaded via ./configure or if it is a more normal
compilation.  Moving the compat.h inclusion into this #ifndef block.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 syshead.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/syshead.h b/syshead.h
index fba6f84..f121114 100644
--- a/syshead.h
+++ b/syshead.h
@@ -34,9 +34,9 @@
 #endif
 #ifndef PACKAGE_NAME
 #include "config.h"
+#include "compat.h"
 #endif
 
-#include "compat.h"
 
 /* branch prediction hints */
 #if defined(__GNUC__)
-- 
1.7.4.4


