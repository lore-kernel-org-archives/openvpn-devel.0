From: Antonio Quartulli <a@...2181...>
Date: Thu, 21 Apr 2022 15:19:09 +0200
Message-Id: <20220421131909.32053-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] auth-pam.c: add missing include limits.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>, Michelangelo Scopelliti <kernelpanic@...1278...>

On most systems limits.h is pulled in by some other header and thus no
error is ever triggered, but it's possible to find the right environment
which lackis this and prevents compiling auth-pam.c (possibly when using
LibreSSL).

Include the header explicitly as it includes the definition of PATH_MAX.

(note that this bug is fixed in Gentoo since 2020 by including a custom
patch, but apparently the issue was never reported upstream)

Reported-by: Michelangelo Scopelliti <kernelpanic@...1278...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/plugins/auth-pam/auth-pam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index f893b51f..70339445 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -47,6 +47,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <syslog.h>
+#include <limits.h>
 #include "utils.h"
 
 #include <openvpn-plugin.h>
-- 
2.35.1


