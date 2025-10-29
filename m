From: Gert Doering <gert@...1296...>
Date: Wed, 29 Oct 2025 07:53:10 +0100
Message-ID: <20251029065316.10182-1-gert@...1296...>
In-Reply-To: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
References: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix logic when pushed cipher triggers
 tun reopen and ignore more options
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

The logic was inverted. Only when link-mtu is used, pushing a cipher can
change the MTU and not the other way round. (found by zeropath)

Also ignore a few more options that should not trigger a reopen of tun
in push message.

Reported-By: contact@...2949...
Found-By: Zeropath
Change-Id: I76eb584024610a6054a069340adbac988abf686c
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1321
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1321
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2c717c7..d7063e6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1025,15 +1025,25 @@
     char line[OPTION_PARM_SIZE];
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        /* peer-id and auth-token might change on restart and this should not trigger reopening tun
+        /* peer-id and auth-token might change on restart and this should not
+         * trigger reopening tun
+         * Also other options that only affect the control channel should
+         * not trigger a reopen of the tun device
          */
-        if (strprefix(line, "peer-id ") || strprefix(line, "auth-token ")
-            || strprefix(line, "auth-token-user "))
+        if (strprefix(line, "peer-id ")
+            || strprefix(line, "auth-token ")
+            || strprefix(line, "auth-token-user")
+            || strprefix(line, "protocol-flags ")
+            || strprefix(line, "key-derivation ")
+            || strprefix(line, "explicit-exit-notify ")
+            || strprefix(line, "ping ")
+            || strprefix(line, "ping-restart ")
+            || strprefix(line, "ping-timer "))
         {
             continue;
         }
         /* tun reopen only needed if cipher change can change tun MTU */
-        if (strprefix(line, "cipher ") && !opt->ce.tun_mtu_defined)
+        if (strprefix(line, "cipher ") && opt->ce.tun_mtu_defined)
         {
             continue;
         }

