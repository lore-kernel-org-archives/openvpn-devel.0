From: <steffan.karger@...1435...>
Date: Tue, 24 Nov 2015 15:00:35 +0100
Message-ID: <1448373635-21649-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove nonsense const specifier in
	nonfatal() return value
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

From: Steffan Karger <steffan.karger@...1435...>

Return values are rvalues, and can not be changed anyway.  Adding const
does not make sense here at all.  (What was I thinking...?)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index e6c55f0..1dc0864 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -353,7 +353,7 @@ ignore_sys_error (const int err)
 }
 
 /** Convert fatal errors to nonfatal, don't touch other errors */
-static inline const unsigned int
+static inline unsigned int
 nonfatal(const unsigned int err) {
   return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
-- 
2.1.4


