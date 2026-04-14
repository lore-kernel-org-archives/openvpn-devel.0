From: Gert Doering <gert@...1296...>
Date: Tue, 14 Apr 2026 07:57:14 +0200
Message-ID: <20260414055721.16857-1-gert@...1296...>
In-Reply-To: <gerrit.1774983232000.I9468811fd434e17645957fc12770aa2b9ed98fb8@...2715...>
References: <gerrit.1774983232000.I9468811fd434e17645957fc12770aa2b9ed98fb8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Log when writing username/password to
 TLS buffer fails
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

From: Selva Nair <selva.nair@...277...>

Currently we get an unhelpful "Key Method #2 failed" error.
Add a more specific warning message.

Change-Id: I9468811fd434e17645957fc12770aa2b9ed98fb8
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1600
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1600
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 576157d..5868d53 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2125,10 +2125,12 @@
 
         if (!write_string(buf, up->username, -1))
         {
+            msg(M_WARN, "WARNING: Failed to write auth username to TLS buffer");
             goto error;
         }
         else if (!write_string(buf, up->password, -1))
         {
+            msg(M_WARN, "WARNING: Failed to write auth password to TLS buffer");
             goto error;
         }
         /* save username for auth-token which may get pushed later */

