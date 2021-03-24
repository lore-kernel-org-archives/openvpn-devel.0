From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Mar 2021 23:23:28 +0100
Message-Id: <20210324222330.455-2-arne@...1227...>
In-Reply-To: <20210324222330.455-1-arne@...1227...>
References: <20210324222330.455-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/4] Fix unchecked signess conversions
 reported by MSVC
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

Whenever possible the types have been aligned in the various parts of
OpenVPN. If that was not possible, an explicit cast to a narrower type
has been added.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/console_builtin.c | 2 +-
 src/openvpn/dhcp.c            | 2 +-
 src/openvpn/multi.h           | 2 +-
 src/openvpn/options.h         | 2 +-
 src/openvpn/packet_id.h       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 445928bf..74a0e2b6 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -74,7 +74,7 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
     if (in != INVALID_HANDLE_VALUE
         && err != INVALID_HANDLE_VALUE
         && !win32_service_interrupt(&win32_signal)
-        && WriteFile(err, prompt, strlen(prompt), &len, NULL))
+        && WriteFile(err, prompt, (DWORD)strlen(prompt), &len, NULL))
     {
         bool is_console = (GetFileType(in) == FILE_TYPE_CHAR);
         DWORD flags_save = 0;
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index c19370eb..1e79ccc4 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -113,7 +113,7 @@ do_extract(struct dhcp *dhcp, int optlen)
                         const int owlen = len + 2;        /* len of data to overwrite */
                         uint8_t *src = dest + owlen;
                         uint8_t *end = p + optlen;
-                        const int movlen = end - src;
+                        const size_t movlen = end - src;
                         if (movlen > 0)
                         {
                             memmove(dest, src, movlen);   /* overwrite router option */
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7669508c..65f64659 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -181,7 +181,7 @@ struct multi_context {
     struct mroute_addr local;
     bool enable_c2c;
     int max_clients;
-    int tcp_queue_limit;
+    unsigned int tcp_queue_limit;
     int status_file_version;
     int n_clients; /* current number of authenticated clients */
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f3208c71..d8e91fbc 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -457,7 +457,7 @@ struct options
     bool ccd_exclusive;
     bool disable;
     int n_bcast_buf;
-    int tcp_queue_limit;
+    unsigned int tcp_queue_limit;
     struct iroute *iroutes;
     struct iroute_ipv6 *iroutes_ipv6;                   /* IPv6 */
     bool push_ifconfig_defined;
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 3b58da22..0d2e094d 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -316,7 +316,7 @@ packet_id_close_to_wrapping(const struct packet_id_send *p)
 static inline bool
 check_timestamp_delta(time_t remote, unsigned int max_delta)
 {
-    unsigned int abs;
+    time_t abs;
     const time_t local_now = now;
 
     if (local_now >= remote)
-- 
2.30.1


