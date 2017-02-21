From: David Sommerseth <davids@...515...>
Date: Tue, 21 Feb 2017 20:27:35 +0100
Message-Id: <20170221192737.24166-2-davids@...515...>
In-Reply-To: <20170221192737.24166-1-davids@...515...>
References: <20170221192737.24166-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2 1/3] dev-tools: lz4-rebaser tool carried
	a typo
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

The HAVE_CONFIG_H block which gets added to compat-lz4.c was
missing a # before the first ifdef statement.

Signed-off-by: David Sommerseth <davids@...515...>
---
 dev-tools/lz4-rebaser.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dev-tools/lz4-rebaser.sh b/dev-tools/lz4-rebaser.sh
index 8a45ffd..4ef4de8 100755
--- a/dev-tools/lz4-rebaser.sh
+++ b/dev-tools/lz4-rebaser.sh
@@ -50,7 +50,7 @@ echo "* Porting upstream lz4.c to compat-lz4.c"
 /* This file has been backported by $0
  * from upstream lz4 commit $lz4_commit ($lz4_tag)
  */
-ifdef HAVE_CONFIG_H
+#ifdef HAVE_CONFIG_H
 #include "config.h"
 #elif defined(_MSC_VER)
 #include "config-msvc.h"
-- 
2.11.0


