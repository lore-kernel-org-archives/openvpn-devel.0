From: Gert Doering <gert@...1296...>
Date: Sat,  4 Oct 2025 16:19:30 +0200
Message-ID: <20251004141935.17815-1-gert@...1296...>
In-Reply-To: <gerrit.1758727613000.Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9@...2715...>
References: <gerrit.1758727613000.Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] route: Fix a unused-but-set-variable
 warning on OpenBSD
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

So we could enable -Werror for OpenBSD builds.

Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1214
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1214
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 156a99e..05a0c8f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2221,6 +2221,7 @@
         device = r6->iface;
         gateway_needed = true;
     }
+    (void)device; /* unused on some platforms */
 
     /* if we used a gateway on "add route", we also need to specify it on
      * delete, otherwise some OSes will refuse to delete the route

