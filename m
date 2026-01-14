From: Gert Doering <gert@...1296...>
Date: Wed, 14 Jan 2026 17:02:32 +0100
Message-ID: <20260114160238.31321-1-gert@...1296...>
In-Reply-To: <gerrit.1765959951000.I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5@...2715...>
References: <gerrit.1765959951000.I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add check for bind-dev in DCO options
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

From: Brandon Currell <brandon+git@...2989...>

Github: OpenVPN/openvpn#683

Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1447
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1447
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index e41d59f..06d5920 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -317,6 +317,12 @@
         }
     }
 
+    if (o->bind_dev)
+    {
+        msg(msglevel, "Note: bind-dev not supported with DCO, disabling data channel offload");
+        return false;
+    }
+
 #if defined(_WIN32)
     if (o->mode == MODE_SERVER)
     {

