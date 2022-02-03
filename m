From: Antonio Quartulli <a@...2181...>
Date: Thu,  3 Feb 2022 09:26:20 +0100
Message-Id: <20220203082620.8186-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] keyingmaterialexporter.c: include strings.h
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
Cc: Antonio Quartulli <a@...2181...>

strcasecmp() was initially declared in string.h and subsequently moved
to strings.h. For historical reasons it still exists in string.h, but
would require _DEFAULT_SOURCE to be defined.

Due to the above, just include strings.h as currently dictated by the
manpage.

Fixes the following warning:

keying-material-exporter-demo/keyingmaterialexporter.c:155:14: warning: implicit declaration of function  strncasecmp’; did you mean ‘strncmp’? [-Wimplicit-function-declaration]
  155 |         if (!strncasecmp(objbuf, "CN", 2))
      |              ^~~~~~~~~~~
      |              strncmp

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .../keying-material-exporter-demo/keyingmaterialexporter.c       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 1f47cb35..e2820418 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -29,6 +29,7 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <strings.h>
 #include <stdlib.h>
 
 #include "openvpn-plugin.h"
-- 
2.34.1


