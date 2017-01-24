From: Steffan Karger <steffan@...1856...>
Date: Tue, 24 Jan 2017 21:38:24 +0100
Message-Id: <1485290304-12292-1-git-send-email-steffan@...1856...>
In-Reply-To: <20170124125537.GR940@...1296...>
References: <20170124125537.GR940@...1296...>
Subject: [Openvpn-devel] [PATCH] Allow changing cipher from a ccd file
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
Cc: openvpn-users@lists.sourceforge.net

As described in msg  <374a7eb7-f539-5231-623b-41f208ed856e@...1823...> on
openvpn-devel@lists.sourceforge.net, clients that are compiled with
--disable-occ (included in --enable-small) won't send an options string.
Without the options string, the 2.4 server doesn't know which cipher to
use for poor man's NCP.

This patch allows working around that issue by allowing the 'cipher'
directive to be used in --client-config-dir files.  That way, a server
admin can add ccd files to specify per-client which cipher to use.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 2 +-
 src/openvpn/options.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4b6d720..6f89616 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7536,7 +7536,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "cipher") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_NCP);
+        VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
         options->ciphername = p[1];
     }
     else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a14f2ab..f4f0226 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -628,7 +628,7 @@ struct options
 #define OPT_P_MTU             (1<<14) /* TODO */
 #define OPT_P_NICE            (1<<15)
 #define OPT_P_PUSH            (1<<16)
-#define OPT_P_INSTANCE        (1<<17)
+#define OPT_P_INSTANCE        (1<<17) /**< Allow usage in ccd file */
 #define OPT_P_CONFIG          (1<<18)
 #define OPT_P_EXPLICIT_NOTIFY (1<<19)
 #define OPT_P_ECHO            (1<<20)
-- 
2.7.4


