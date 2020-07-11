From: Arne Schwabe <arne@...1227...>
Date: Sat, 11 Jul 2020 11:36:42 +0200
Message-Id: <20200711093655.23686-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v5 01/14] Allow changing fallback cipher
 from ccd files/client-connect
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

This allows to control the fallback cipher that is used when the
client/server do have any common cipher on a per client basis.

The patch is similar to Steffan's
[PATCH v4] Allow changing cipher from a ccd file.

Steffan's old patch also moves the cipher negotiation to
multi_established_connection() which I independently discovered and
implemented in

Extract process_incoming_push_reply from process_incoming_push_msg
(#FIXME add commitsh when commited to master)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 2 +-
 src/openvpn/options.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b93fd4fe..bf2760e1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7892,7 +7892,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "cipher") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_NCP);
+        VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
         options->ciphername = p[1];
     }
     else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c83a46aa..c37006d3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -677,7 +677,7 @@ struct options
 #define OPT_P_MTU             (1<<14) /* TODO */
 #define OPT_P_NICE            (1<<15)
 #define OPT_P_PUSH            (1<<16)
-#define OPT_P_INSTANCE        (1<<17)
+#define OPT_P_INSTANCE        (1<<17) /**< allowed in ccd, client-connect etc*/
 #define OPT_P_CONFIG          (1<<18)
 #define OPT_P_EXPLICIT_NOTIFY (1<<19)
 #define OPT_P_ECHO            (1<<20)
-- 
2.26.2


