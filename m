From: Gert Doering <gert@...1296...>
Date: Thu, 20 Feb 2025 08:43:27 +0100
Message-ID: <20250220074327.24922-1-gert@...1296...>
In-Reply-To: <gerrit.1740037224000.Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937@...2715...>
References: <gerrit.1740037224000.Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco-win: simplify control packets
 prepend code
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

From: Lev Stipakov <lev@...515...>

Eliminate unneeded temporary struct sockaddr_in buffer.

Change-Id: Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/900
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index c370f2c..ee04a96 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1125,15 +1125,11 @@
     {
         if (to->dest.addr.sa.sa_family == AF_INET)
         {
-            struct sockaddr_in sa;
-            memcpy(&sa, &to->dest.addr.in4, sizeof(sa));
-            buf_write_prepend(buf, &sa, sizeof(sa));
+            buf_write_prepend(buf,  &to->dest.addr.in4, sizeof(struct sockaddr_in));
         }
         else
         {
-            struct sockaddr_in6 sa;
-            memcpy(&sa, &to->dest.addr.in6, sizeof(sa));
-            buf_write_prepend(buf, &sa, sizeof(sa));
+            buf_write_prepend(buf, &to->dest.addr.in6, sizeof(struct sockaddr_in6));
         }
     }
 

