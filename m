From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 16 Feb 2018 14:45:39 +0100
Message-ID: <1518788739-16610-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix format errors when cross-compiling for
 Windows
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

Not all supported windows formatting libs are C99 compliant and some do not
grasp %ll (similar to %zu).  Use int64_t and PRIi64 to work around that.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index bf987d2..bc14e8c 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -342,8 +342,8 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
                 struct timeval tv;
                 gettimeofday(&tv, NULL);
 
-                fprintf(fp, "%lld.%06lu %x %s%s%s%s",
-                        (long long)tv.tv_sec,
+                fprintf(fp, "%"PRIi64".%06lu %x %s%s%s%s",
+                        (int64_t)tv.tv_sec,
                         (unsigned long)tv.tv_usec,
                         flags,
                         prefix,
-- 
2.7.4


