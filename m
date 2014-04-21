From: Steffan Karger <steffan@...1856...>
Date: Mon, 21 Apr 2014 13:37:18 +0200
Message-Id: <1398080238-19662-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix build system to accept non-system
	crypto library locations for plugins.
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

Flags like {OPEN,POLAR}SSL_CFLAGS were used by the core build, but not by
the plugins. However, all plugins include openvpn-plugin.h, which need
crypto/ssl headers.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/plugins/auth-pam/Makefile.am  | 5 +++--
 src/plugins/down-root/Makefile.am | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/plugins/auth-pam/Makefile.am b/src/plugins/auth-pam/Makefile.am
index 701a749..2aef311 100644
--- a/src/plugins/auth-pam/Makefile.am
+++ b/src/plugins/auth-pam/Makefile.am
@@ -8,8 +8,9 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 AM_CFLAGS = \
-	-I$(top_srcdir)/include
-	$(PLUGIN_AUTH_PAM_CFLAGS)
+	-I$(top_srcdir)/include \
+	$(PLUGIN_AUTH_PAM_CFLAGS) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if ENABLE_PLUGIN_AUTH_PAM
 plugin_LTLIBRARIES = openvpn-plugin-auth-pam.la
diff --git a/src/plugins/down-root/Makefile.am b/src/plugins/down-root/Makefile.am
index 064aa30..7ca5a4e 100644
--- a/src/plugins/down-root/Makefile.am
+++ b/src/plugins/down-root/Makefile.am
@@ -8,7 +8,8 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 AM_CFLAGS = \
-	-I$(top_srcdir)/include
+	-I$(top_srcdir)/include \
+	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if ENABLE_PLUGIN_DOWN_ROOT
 plugin_LTLIBRARIES = openvpn-plugin-down-root.la
-- 
1.8.3.2


