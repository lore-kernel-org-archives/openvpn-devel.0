From: Simon Rozman <simon@...2293...>
Date: Thu, 12 Oct 2017 12:34:48 +0200
Message-Id: <20171012103448.7632-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Fix local #include to use quoted form
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

.h include files from the same folder or addressed relatively to the
same folder should be #included using quoted form in MSVC. The angled
form is reserved for include files from folders specified using /I
path.

Using angled form, MSVC fails to locate local #include file, unless
current folder is added to the include search path: /I .
---
 src/openvpnserv/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 0c9098f..e77d7ab 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -21,8 +21,9 @@
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <service.h>
-#include <validate.h>
+#include "service.h"
+#include "validate.h"
+
 /*
  * These are necessary due to certain buggy implementations of (v)snprintf,
  * that don't guarantee null termination for size > 0.
-- 
2.9.0.windows.1

This patch is a stand-alone fix, that was accidentaly included in
"[PATCH 06/13] openvpnserv.vcxproj project file recreated using Visual
Studio 2017".

I estimate this way it'll get better chance of being ACK-ed. :)

Best regards,
Simon

