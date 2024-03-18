From: Gert Doering <gert@...1296...>
Date: Mon, 18 Mar 2024 19:17:44 +0100
Message-ID: <20240318181744.20625-1-gert@...1296...>
In-Reply-To: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
References: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Disable DCO if proxy is set via
 management
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

From: Lev Stipakov <lev@...515...>

Commit

    45a1cb2a ("Disable DCO if proxy is set via management")

attempted to disable DCO when proxy is set via management interface. However,
at least on Windows this doesn't work, since:

 - setting tuntap_options->disable_dco to true is not enough to disable DCO
 - at this point it is a bit too late, since we've already done DCO-specific
adjustments

Since proxy could be set via management only if --management-query-proxy is specified,
the better way would be to add a check to dco_check_startup_option().

Github: fixes OpenVPN/openvpn#522

Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/543
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 14430d3..540b5a8 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -387,6 +387,12 @@
         return false;
     }
 
+    if (o->management_flags & MF_QUERY_PROXY)
+    {
+        msg(msglevel, "Note: --management-query-proxy disables data channel offload.");
+        return false;
+    }
+
     /* now that all options have been confirmed to be supported, check
      * if DCO is truly available on the system
      */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b3931..6a3040f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -221,12 +221,6 @@
     }
     else if (p[2] && p[3])
     {
-        if (dco_enabled(&c->options))
-        {
-            msg(M_INFO, "Proxy set via management, disabling Data Channel Offload.");
-            c->options.tuntap_options.disable_dco = true;
-        }
-
         if (streq(p[1], "HTTP"))
         {
             struct http_proxy_options *ho;

