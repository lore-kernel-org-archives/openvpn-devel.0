From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Feb 2023 20:14:38 +0100
Message-Id: <20230203191440.136050-4-frank@...2641...>
In-Reply-To: <20230203191440.136050-1-frank@...2641...>
References: <20230203191440.136050-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Windows: fix wrong printf format in
 x_check_status
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/error.c   | 4 ++--
 src/openvpn/syshead.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 89a08cec..a2c9aa4c 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -695,14 +695,14 @@ x_check_status(int status,
         {
             if (extended_msg)
             {
-                msg(x_cs_info_level, "%s %s [%s]: %s (fd=%d,code=%d)", description,
+                msg(x_cs_info_level, "%s %s [%s]: %s (fd=" SOCKET_PRINTF ",code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
                     extended_msg, openvpn_strerror(my_errno, crt_error, &gc),
                     sock ? sock->sd : -1, my_errno);
             }
             else
             {
-                msg(x_cs_info_level, "%s %s: %s (fd=%d,code=%d)", description,
+                msg(x_cs_info_level, "%s %s: %s (fd=" SOCKET_PRINTF ",code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
                     openvpn_strerror(my_errno, crt_error, &gc),
                     sock ? sock->sd : -1, my_errno);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index fe91bc11..58cdd6bd 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -442,9 +442,11 @@ typedef unsigned short sa_family_t;
  */
 #ifdef _WIN32
 #define SOCKET_UNDEFINED (INVALID_SOCKET)
+#define SOCKET_PRINTF "%lld"
 typedef SOCKET socket_descriptor_t;
 #else
 #define SOCKET_UNDEFINED (-1)
+#define SOCKET_PRINTF "%d"
 typedef int socket_descriptor_t;
 #endif
 
-- 
2.34.1


