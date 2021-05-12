From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:08 +0200
Message-Id: <20210512131511.1309914-7-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/9] Add noreturn attribute for MSVC to
 assert_failed method.
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/error.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1a5521654..469afe20a 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -202,8 +202,14 @@ FILE *msg_fp(const unsigned int flags);
 #define ASSERT(x) do { if (!(x)) {assert_failed(__FILE__, __LINE__, NULL);}} while (false)
 #endif
 
+#ifdef _MSC_VER
+__declspec(noreturn)
+#endif
 void assert_failed(const char *filename, int line, const char *condition)
-__attribute__((__noreturn__));
+#ifndef _MSC_VER
+__attribute__((__noreturn__))
+#endif
+;
 
 /* Poor-man's static_assert() for when not supplied by assert.h, taken from
  * Linux's sys/cdefs.h under GPLv2 */
-- 
2.31.1


