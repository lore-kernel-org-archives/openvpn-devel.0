From: Gert Doering <gert@...1296...>
Date: Mon, 27 Oct 2025 22:33:02 +0100
Message-ID: <20251027213308.5588-1-gert@...1296...>
In-Reply-To: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
References: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Avoid possible race condition that kill
 OpenVPN itself
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

If for whatever reason the child pid is zero, we would kill ourselves
since killing 0 means killing the own process group.

Reported-By: contact@...2949...
Found-By: Zeropath
Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1319
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1319
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 4d48a31..124db6d 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -128,7 +128,12 @@
         close(tt->fd);
         tt->fd = 0;
     }
-    kill(tt->afunix.childprocess, SIGINT);
+    /* only kill the child process if the PID is not 0 to avoid killing
+     * ourselves by accident */
+    if (tt->afunix.childprocess)
+    {
+        kill(tt->afunix.childprocess, SIGINT);
+    }
 
     free(tt->actual_name);
     free(tt);

