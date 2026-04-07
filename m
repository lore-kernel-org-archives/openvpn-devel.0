From: Gert Doering <gert@...1296...>
Date: Tue,  7 Apr 2026 22:52:28 +0200
Message-ID: <20260407205235.31126-1-gert@...1296...>
In-Reply-To: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
References: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Clarify operator precedence in a & b ? c
 : d
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

As suggested by cppcheck.

Change-Id: Ia153e0de888c0ee21199b192f3471ce4c08cb5c7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1619
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1619
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 62389af..03d880f 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -399,7 +399,7 @@
 static inline msglvl_t
 nonfatal(const msglvl_t err)
 {
-    return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
+    return (err & M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
 
 static inline int
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 186b2d2..e4905c9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7043,12 +7043,12 @@
         if (options->routes->flags & RG_REROUTE_GW)
         {
             setenv_int(es, "route_redirect_gateway_ipv4",
-                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+                       (options->routes->flags & RG_BLOCK_LOCAL) ? 2 : 1);
         }
         if (options->routes_ipv6 && (options->routes_ipv6->flags & RG_REROUTE_GW))
         {
             setenv_int(es, "route_redirect_gateway_ipv6",
-                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+                       (options->routes->flags & RG_BLOCK_LOCAL) ? 2 : 1);
         }
 #ifdef _WIN32
         /* we need this here to handle pushed --redirect-gateway */
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index f60e2f2..7fc8c14 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -276,7 +276,7 @@
 
         const WCHAR *mesg[] = { msg[0], msg[1] };
         ReportEvent(hEventSource,
-                    flags & MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
+                    (flags & MSG_FLAGS_ERROR) ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
                     0,
                     EVT_TEXT_2,
                     NULL,

