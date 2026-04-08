From: Gert Doering <gert@...1296...>
Date: Wed,  8 Apr 2026 22:42:07 +0200
Message-ID: <20260408204213.9892-1-gert@...1296...>
In-Reply-To: <gerrit.1775421558000.Idfe2afd9616e17f0f80a914ff054ae18f0b6972b@...2715...>
References: <gerrit.1775421558000.Idfe2afd9616e17f0f80a914ff054ae18f0b6972b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] networking_sitnl: Make
 sitnl_parse_rtattr* return void
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

From: Frank Lichtenheld <frank@...2641...>

It returned a constant value so it didn't actually
do anything.

Identified by cppcheck.

Change-Id: Idfe2afd9616e17f0f80a914ff054ae18f0b6972b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1614
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1614
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index baf6f89..b3f8e2b 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1351,7 +1351,7 @@
     return ret;
 }
 
-static int
+static void
 sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,
                          unsigned short flags)
 {
@@ -1375,14 +1375,12 @@
     {
         msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=%u)", __func__, len, rta->rta_len);
     }
-
-    return 0;
 }
 
-static int
+static void
 sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len)
 {
-    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
+    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
 }
 
 #define sitnl_parse_rtattr_nested(tb, max, rta) \
@@ -1394,23 +1392,14 @@
     char *type = arg;
     struct ifinfomsg *ifi = NLMSG_DATA(n);
     struct rtattr *tb[IFLA_MAX + 1];
-    int ret;
 
-    ret = sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));
-    if (ret < 0)
-    {
-        return ret;
-    }
+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));
 
     if (tb[IFLA_LINKINFO])
     {
         struct rtattr *tb_link[IFLA_INFO_MAX + 1];
 
-        ret = sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
-        if (ret < 0)
-        {
-            return ret;
-        }
+        sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
 
         if (!tb_link[IFLA_INFO_KIND])
         {

