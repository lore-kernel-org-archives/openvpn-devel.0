From: David Sommerseth <openvpn@...2080...>
Date: Wed, 20 Apr 2022 14:13:20 +0200
Message-Id: <20220420121322.42732-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] dev-tools: Remove no longer needed
 openvpn-plugin.h.in patching
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

The bug in uncrustify 0.64 is no longer causing us issues as we now
require at least v0.72.

This workaround was added as part of the initial reformat-all inclusion,
in commit 2417d55c4945d491e.

Signed-off-by: David Sommerseth <davids@...515...>
---
 .../after_include_openvpn-plugin.h.in.patch         | 13 -------------
 .../before_include_openvpn-plugin.h.in.patch        | 13 -------------
 dev-tools/special-files.lst                         |  1 -
 3 files changed, 27 deletions(-)
 delete mode 100644 dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch
 delete mode 100644 dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch

diff --git a/dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch b/dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch
deleted file mode 100644
index 100da078..00000000
--- a/dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch
+++ /dev/null
@@ -1,13 +0,0 @@
-diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
-index 05bffab..05b4b6a 100644
---- a/include/openvpn-plugin.h.in
-+++ b/include/openvpn-plugin.h.in
-@@ -169,7 +169,7 @@ typedef void *openvpn_plugin_handle_t;
- /*
-  * We are compiling OpenVPN.
-  */
--/* #define OPENVPN_PLUGIN_DEF        typedef */
-+#define OPENVPN_PLUGIN_DEF        typedef
- #define OPENVPN_PLUGIN_FUNC(name) (*name)
-
- #else  /* ifdef OPENVPN_PLUGIN_H */
diff --git a/dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch b/dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch
deleted file mode 100644
index 679c4149..00000000
--- a/dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch
+++ /dev/null
@@ -1,13 +0,0 @@
-diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
-index 34ad18b..f4c5472 100644
---- a/include/openvpn-plugin.h.in
-+++ b/include/openvpn-plugin.h.in
-@@ -169,7 +169,7 @@ typedef void *openvpn_plugin_handle_t;
- /*
-  * We are compiling OpenVPN.
-  */
--#define OPENVPN_PLUGIN_DEF        typedef
-+// #define OPENVPN_PLUGIN_DEF        typedef
- #define OPENVPN_PLUGIN_FUNC(name) (*name)
-
- #else
diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
index f3f77ea3..64ee9e1a 100644
--- a/dev-tools/special-files.lst
+++ b/dev-tools/special-files.lst
@@ -1,4 +1,3 @@
 E:doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated, exclude it
 E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
 E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
-P:include/openvpn-plugin.h.in          # uncrustify segfaults, patch it before+after
-- 
2.27.0


