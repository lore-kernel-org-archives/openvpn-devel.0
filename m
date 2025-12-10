From: Gert Doering <gert@...1296...>
Date: Wed, 10 Dec 2025 08:29:44 +0100
Message-ID: <20251210072951.25753-1-gert@...1296...>
In-Reply-To: <gerrit.1765297693000.I6debe8bbedd5a08da417bfee1243a43ef6df7980@...2715...>
References: <gerrit.1765297693000.I6debe8bbedd5a08da417bfee1243a43ef6df7980@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: set adapter DNS only with
 search domains
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

From: Heiko Hund <heiko@...2662...>

With NRPT the adapter name server configuration is not needed
theoretically. However DNS config is not showing with traditional
tools like ipconfig if they are left out. More importantly if
there are no DNS servers configured for an adapter the adapter
specific search domains are not recognized by the Windows resolver.

However, adding the servers to the adapter has the side effect, that
general look-ups are now also done using this adapter, which might
come as unexpected and yield wrong results, if there is some trickery
happening with the default DNS, for example.

As a workaround, set the adapter DNS only when strictly needed.

Change-Id: I6debe8bbedd5a08da417bfee1243a43ef6df7980
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Selva Nair <selva.nair@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1429
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1429
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Selva Nair <selva.nair@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6f04f6b..9327dfa 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2869,11 +2869,19 @@
         goto out;
     }
 
-    /* Set name servers */
-    err = SetNameServerAddresses(iid, msg->addresses);
-    if (err)
+    /*
+     * Set DNS on the adapter for search domains to be considered.
+     * If split DNS is configured, do this only when search domains
+     * are given, so that look-ups for other domains do not go over
+     * the VPN all the time.
+     */
+    if (msg->search_domains[0] || !msg->resolve_domains[0])
     {
-        goto out;
+        err = SetNameServerAddresses(iid, msg->addresses);
+        if (err)
+        {
+            goto out;
+        }
     }
 
     /* Set search domains, if any */

