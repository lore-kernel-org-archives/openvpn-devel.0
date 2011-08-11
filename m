From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 11 Aug 2011 07:00:31 +0000
Message-Id: <1313046031-14499-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1312980908-25157-2-git-send-email-heiko.hund@...1489...>
References: <1312980908-25157-2-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 1/2] define IN6_ARE_ADDR_EQUAL macro for
	WIN32
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

Windows headers do not define the IN6_ARE_ADDR_EQUAL macro. It needs
to be defined locally when building for WIN32 with IPv6 enabled.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 win32.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/win32.h b/win32.h
index d0ecc85..87d8ecc 100644
--- a/win32.h
+++ b/win32.h
@@ -41,6 +41,16 @@
  * development environment.
  */
 
+#ifdef USE_PF_INET6
+
+/* MSVC headers do not define this macro, so do it here */
+#ifndef IN6_ARE_ADDR_EQUAL
+#define IN6_ARE_ADDR_EQUAL(a,b) \
+  (memcmp ((const void*)(a), (const void*)(b), sizeof (struct in6_addr)) == 0)
+#endif
+
+#endif
+
 void init_win32 (void);
 void uninit_win32 (void);
 
-- 
1.7.5.4


