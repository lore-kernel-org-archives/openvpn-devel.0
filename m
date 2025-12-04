From: Gert Doering <gert@...1296...>
Date: Thu,  4 Dec 2025 14:45:16 +0100
Message-ID: <20251204134521.20025-1-gert@...1296...>
In-Reply-To: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
References: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix dco with null cipher being enabled
 without auth none
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

This is a corner case and only the FreeBSD DCO module support the
none encryption but as long as it supports it, we should only
enable it when the configuration actually allows to enable it.

Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1369
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1369
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7abdad3..6a1a5c9 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -474,6 +474,18 @@
             gc_free(&gc);
             return false;
         }
+        /* FreeBSD supports none as cipher type but requires auth none to be
+         * be also enabled */
+        if (strcmp(token, "none") == 0 && strcmp(o->authname, "none") != 0)
+        {
+            msg(msglevel,
+                "Note: cipher '%s' in --data-ciphers is only supported "
+                "with --auth=none by ovpn-dco, disabling data channel "
+                "offload.",
+                token);
+            gc_free(&gc);
+            return false;
+        }
     }
     gc_free(&gc);
 

