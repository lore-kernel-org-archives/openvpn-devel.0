From: Gert Doering <gert@...1296...>
Date: Thu, 23 Oct 2025 17:56:08 +0200
Message-ID: <20251023155614.20642-1-gert@...1296...>
In-Reply-To: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
References: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Warn if push is used without --mode
 server/--server/--server-bridge
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

From: Arne Schwabe <arne@...1227...>

This is not a supported configuration and will often work good enough
to get a connection working but will operate more in a weird pre P2P
negotiation compatibility way rather than actually negotiating
protocol features.

Also remove an anused macro.

Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1288
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1288
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index ccc1374..347a251 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -497,6 +497,9 @@
   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
   ``--rcvbuf``, ``--session-timeout``
 
+  Note: using ``--push`` requires OpenVPN to run in ``--mode server`` (or
+  using of one of `--server`, `--server-bridge` helper directives).
+
 --push-remove opt
   Selectively remove all ``--push`` options matching "opt" from the option
   list for a client. ``opt`` is matched as a substring against the whole
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 65c6b3b..9c02a8c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2690,6 +2690,13 @@
         MUST_BE_UNDEF(vlan_accept, "vlan-accept");
         MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
         MUST_BE_UNDEF(force_key_material_export, "force-key-material-export");
+
+        if (options->push_list.head)
+        {
+            msg(M_WARN, "Note: Using --push without --mode server is an "
+                        "unsupported configuration. Negotiation of OpenVPN "
+                        "features is expected to fail.");
+        }
     }
 
     /*
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 009904a..24253af 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -768,16 +768,11 @@
 #define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
-#define PUSH_DEFINED(opt) ((opt)->push_list)
 
 #ifndef PULL_DEFINED
 #define PULL_DEFINED(opt) (false)
 #endif
 
-#ifndef PUSH_DEFINED
-#define PUSH_DEFINED(opt) (false)
-#endif
-
 #ifdef _WIN32
 #define ROUTE_OPTION_FLAGS(o) ((o)->route_method & ROUTE_METHOD_MASK)
 #else

