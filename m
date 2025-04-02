From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 15:21:42 +0200
Message-ID: <20250402132148.18810-1-gert@...1296...>
In-Reply-To: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
References: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix FreeBSD-DCO and Multisocket
 interaction
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

From: Gianmarco De Gregori <gianmarco@...2726...>

FreeBSD-DCO does not support TCP as transport protocol so in order to
be able to use DCO in a multi-socket environment we need to check the
local_list entries and disable DCO if any of the listening socket
is TCP.

While at it, removed some dead code left from Multisocket polishing.

Github: closes OpenVPN/openvpn#710

Change-Id: I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/925
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index d00958d..7ad9cb3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -260,10 +260,16 @@
     }
 
 #if defined(TARGET_FREEBSD)
-    if (!proto_is_udp(ce->proto))
+    if (ce->local_list)
     {
-        msg(msglevel, "NOTE: TCP transport disables data channel offload on FreeBSD.");
-        return false;
+        for (int i = 0; i < ce->local_list->len; i++)
+        {
+            if (!proto_is_dgram(ce->local_list->array[i]->proto))
+            {
+                msg(msglevel, "NOTE: TCP transport disables data channel offload on FreeBSD.");
+                return false;
+            }
+        }
     }
 #endif
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 99dd60a..6605a42 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -9577,20 +9577,3 @@
 
     return false;
 }
-
-bool
-has_tcp_in_local_list(const struct options *options)
-{
-    if (options->ce.local_list)
-    {
-        for (int i = 0; i < options->ce.local_list->len; i++)
-        {
-            if (!proto_is_dgram(options->ce.local_list->array[i]->proto))
-            {
-                return true;
-            }
-        }
-    }
-
-    return false;
-}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index fa617c8..8d1ef6c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -921,8 +921,6 @@
 
 bool has_udp_in_local_list(const struct options *options);
 
-bool has_tcp_in_local_list(const struct options *options);
-
 /**
  * Returns whether the current configuration has dco enabled.
  */

