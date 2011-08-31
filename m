From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 31 Aug 2011 14:49:22 +0000
Message-Id: <1314802162-26070-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313046031-14499-1-git-send-email-heiko.hund@...1489...>
References: <1313046031-14499-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH-UPDATE] define IN6_ARE_ADDR_EQUAL macro for
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
to be defined locally when building for WIN32.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>

Update: remove check for USE_PF_INET6 since commit
eb23089183745853fac9414d45a559a478ef51d6 removed the definition
of this macro. IPv6 is now always compiled in.
---
 win32.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/win32.h b/win32.h
index 528af6c..5b18e3c 100644
--- a/win32.h
+++ b/win32.h
@@ -41,6 +41,12 @@
  * development environment.
  */
 
+/* MSVC headers do not define this macro, so do it here */
+#ifndef IN6_ARE_ADDR_EQUAL
+#define IN6_ARE_ADDR_EQUAL(a,b) \
+  (memcmp ((const void*)(a), (const void*)(b), sizeof (struct in6_addr)) == 0)
+#endif
+
 void init_win32 (void);
 void uninit_win32 (void);
 
-- 
1.7.5.4


