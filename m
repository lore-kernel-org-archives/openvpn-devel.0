From: Gert Doering <gert@...1296...>
Date: Thu, 25 Feb 2016 15:58:32 +0100
Message-Id: <1456412312-21936-1-git-send-email-gert@...1296...>
In-Reply-To: <20160225125742.GA21087@...1296...>
References: <20160225125742.GA21087@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix openserv/validate.o linking issues on
	mingw.
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

MinGW fails linking after f3c8a04d6021 if the right header files
(<lm.h> and <shlwapi.h>) are not included.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpnserv/validate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index d7446de..b5809b3 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -25,6 +25,8 @@
 #include "validate.h"
 
 #include <lmaccess.h>
+#include <shlwapi.h>
+#include <lm.h>
 
 static const WCHAR *white_list[] =
     {
-- 
1.9.1


