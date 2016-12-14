From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Dec 2016 10:51:18 +0200
Message-Id: <1481705478-29735-1-git-send-email-lstipakov@...277...>
In-Reply-To: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
Subject: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
	disabled
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

Async push is a sub-feature of plugins.

Trac #783

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/syshead.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index f5008b7..c7c3259 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -702,4 +702,11 @@ socket_defined (const socket_descriptor_t sd)
 #define ENABLE_MEMSTATS
 #endif
 
+/*
+ * Disable async-push if plugins are disabled
+ */
+#if !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH)
+#undef ENABLE_ASYNC_PUSH
+#endif
+
 #endif
-- 
1.9.1


