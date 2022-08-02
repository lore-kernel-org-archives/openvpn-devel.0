From: Antonio Quartulli <a@...2181...>
Date: Tue,  2 Aug 2022 10:23:16 +0200
Message-Id: <20220802082316.1424-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: move availability check to the end of
 check_option_conflict() function
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

To better arrange the order DCO option conflict messages are printed, we
decided to first perform all needed checks on provided options and, only
at the end, if no conflict was detected, to check if DCO is really
available on the system.

This way a user gets prompted with all warnings about their
configuration first and, when everything is fixed, they will see if DCO
is available or not.

While at it, compress the first check in just one if to make the code
simpler.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index a6912d4e..fdf474ca 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -268,18 +268,11 @@ dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
 bool
 dco_check_option_conflict(int msglevel, const struct options *o)
 {
-    if (o->tuntap_options.disable_dco)
-    {
-        /* already disabled by --disable-dco, no need to print warnings */
-        return false;
-    }
-
-    if (!dco_available(msglevel))
-    {
-        return false;
-    }
-
-    if (!o->dev)
+    /* check if DCO was already disabled by the user or if no dev name was
+     * specified at all. In the latter case, later logic will most likely stop
+     * OpenVPN, so no need to print any message here.
+     */
+    if (o->tuntap_options.disable_dco || !o->dev)
     {
         return false;
     }
@@ -361,7 +354,10 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     }
     gc_free(&gc);
 
-    return true;
+    /* now that all options have been confirmed to be supported, check if DCO is
+     * truly available on the system
+     */
+    return dco_available(o);
 }
 
 bool
-- 
2.35.1


