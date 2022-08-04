From: Gert Doering <gert@...1296...>
Date: Thu,  4 Aug 2022 10:25:02 +0200
Message-Id: <20220804082502.1750074-1-gert@...1296...>
In-Reply-To: <20220803194211.1727822-1-gert@...1296...>
References: <20220803194211.1727822-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Break 'try 256 dco devices' loop on EPERM
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

If we get a permission denied error on one DCO device, trying 255 more
times will not succeed, and just fill the log file with errors.

Also, remove the msg() call there because it was at debug level
(needed --verb 4 to be seen), didn't see the correct errno, and the
sitnl code already prints the error.

v2: use "else if"

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 02ded4d7..af283aae 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1883,13 +1883,18 @@ open_tun_dco_generic(const char *dev, const char *dev_type,
         {
             openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
                              "%s%d", dev, i);
-            if (open_tun_dco(tt, ctx, dynamic_name) == 0)
+            int ret = open_tun_dco(tt, ctx, dynamic_name);
+            if (ret == 0)
             {
                 dynamic_opened = true;
                 msg(M_INFO, "DCO device %s opened", dynamic_name);
                 break;
             }
-            msg(D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)", dynamic_name);
+            /* "permission denied" won't succeed if we try 256 times */
+            else if (ret == -EPERM)
+            {
+                break;
+            }
         }
         if (!dynamic_opened)
         {
-- 
2.25.1


