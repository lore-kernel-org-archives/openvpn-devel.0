From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Feb 2023 14:43:23 +0100
Message-Id: <20230214134323.1033590-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use proper print format/casting when
 converting msg_channel handle
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

The current casting triggers a warning on 32bit:

    init.c:1842:66: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

Use the proper printf format specifier for printing a pointer avoiding
the cast alltogether.

In options.c use a cast to intptr_t before converting to a handle to
avoid having to ifdef atoll/atol for 32/64 bit.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    | 3 ++-
 src/openvpn/options.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0ad2c7e09..0d50d9189 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1839,7 +1839,8 @@ do_open_tun(struct context *c, int *error_flags)
 #ifdef _WIN32
         /* store (hide) interactive service handle in tuntap_options */
         c->c1.tuntap->options.msg_channel = c->options.msg_channel;
-        msg(D_ROUTE, "interactive service msg_channel=%" PRIu64, (unsigned long long) c->options.msg_channel);
+        msg(D_ROUTE, "interactive service msg_channel=%" PRIuPTR,
+            (intptr_t) c->options.msg_channel);
 #endif
 
         /* allocate route list structure */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c1ddb0262..679528187 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7882,7 +7882,7 @@ add_option(struct options *options,
 #ifdef _WIN32
         VERIFY_PERMISSION(OPT_P_GENERAL);
         HANDLE process = GetCurrentProcess();
-        HANDLE handle = (HANDLE) atoll(p[1]);
+        HANDLE handle = (HANDLE) ((intptr_t) atoll(p[1]));
         if (!DuplicateHandle(process, handle, process, &options->msg_channel, 0,
                              FALSE, DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
         {
-- 
2.37.1 (Apple Git-137.1)


