From: Gert Doering <gert@...1296...>
Date: Mon,  6 May 2024 16:23:03 +0200
Message-ID: <20240506142303.13198-1-gert@...1296...>
In-Reply-To: <gerrit.1715003428000.Ie2b62bc95371daf7e1eb58e0323835f169399910@...2715...>
References: <gerrit.1715003428000.Ie2b62bc95371daf7e1eb58e0323835f169399910@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Repeat the unknown command in errors
 from management interface
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

This help pinpointing errors in logs from my app

Change-Id: Ie2b62bc95371daf7e1eb58e0323835f169399910
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/584
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 43c5507..415ee7a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1663,7 +1663,7 @@
 #endif
     else
     {
-        msg(M_CLIENT, "ERROR: unknown command, enter 'help' for more options");
+        msg(M_CLIENT, "ERROR: unknown command [%s], enter 'help' for more options", p[0]);
     }
 
 done:

