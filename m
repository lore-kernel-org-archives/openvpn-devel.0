From: David Sommerseth <openvpn@...2080...>
Date: Wed, 20 Apr 2022 14:13:22 +0200
Message-Id: <20220420121322.42732-3-openvpn@...2080...>
In-Reply-To: <20220420121322.42732-1-openvpn@...2080...>
References: <20220420121322.42732-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] dev-tools: Avoid uncrustify mangling
 MAC_FMT macro
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

The MAC_FMT in src/openvpn/misc.h need to be formatted strictly, and
uncrustify does not fully grasp the current code.  So we tell it to not
touch it.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/misc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 7970b60d..d8a15650 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -212,7 +212,9 @@ struct buffer
 prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
 
 #define _STRINGIFY(S) #S
+/* *INDENT-OFF* - uncrustify need to ignore this macro */
 #define MAC_FMT _STRINGIFY(%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx)
+/* *INDENT-ON* */
 #define MAC_PRINT_ARG(_mac) _mac[0], _mac[1], _mac[2],  \
         _mac[3], _mac[4], _mac[5]
 #define MAC_SCAN_ARG(_mac) &_mac[0], &_mac[1], &_mac[2], \
-- 
2.27.0


