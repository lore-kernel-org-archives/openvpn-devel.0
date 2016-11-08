From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Nov 2016 21:18:20 +0100
Message-ID: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Add missing includes in error.h
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

error.h depends on these, but is apparently never used by files that do
not include them.  When implementing the --tls-crypt unit tests, I ran
into this.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/error.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ced2fdf..1d791bb 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -27,6 +27,9 @@
 
 #include "basic.h"
 
+#include <errno.h>
+#include <stdbool.h>
+
 /* #define ABORT_ON_ERROR */
 
 #ifdef ENABLE_PKCS11
-- 
2.7.4


