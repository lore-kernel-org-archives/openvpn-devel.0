From: Antonio Quartulli <a@...2181...>
Date: Wed,  7 Dec 2022 11:02:01 +0100
Message-Id: <20221207100201.6467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] disable DCO if --secret is specified
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
Cc: Antonio Quartulli <a@...2181...>

P2P mode with pre-shared key is deprecated, unsecure and should NOT be
used. This said we still carry it around for a bit and we have to make
sure it does not fights with DCO.

Disable DCO at all when --secret is specified.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index d599dd7e..1cd698bf 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -274,6 +274,12 @@ dco_check_startup_option(int msglevel, const struct options *o)
         return false;
     }
 
+    if (o->shared_secret_file)
+    {
+        msg(msglevel, "--secret is set. Disabling data channel offload");
+        return false;
+    }
+
     if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
     {
         msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
-- 
2.37.4


