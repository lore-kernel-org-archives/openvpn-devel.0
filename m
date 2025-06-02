From: Gert Doering <gert@...1296...>
Date: Mon,  2 Jun 2025 17:21:08 +0200
Message-ID: <20250602152115.27130-1-gert@...1296...>
In-Reply-To: <gerrit.1748876308000.I0e13595c1057c680e1065eae84ca94b273ed9ca1@...2715...>
References: <gerrit.1748876308000.I0e13595c1057c680e1065eae84ca94b273ed9ca1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Do not segfault on missing --dh in
 server config
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

Change-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1037
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0d648ba..b9708343 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3698,7 +3698,7 @@
 
     if (o->tls_server)
     {
-        if (streq(o->dh_file, "none"))
+        if (o->dh_file && streq(o->dh_file, "none"))
         {
             o->dh_file = NULL;
         }

