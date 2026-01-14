From: Gert Doering <gert@...1296...>
Date: Wed, 14 Jan 2026 14:58:02 +0100
Message-ID: <20260114135807.20637-1-gert@...1296...>
In-Reply-To: <gerrit.1768308239000.Ic1c8f24de423541bdc85e70b5a688213800d86de@...2715...>
References: <gerrit.1768308239000.Ic1c8f24de423541bdc85e70b5a688213800d86de@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socks: In establish_socks_proxy_udpassoc
 check result of recv_socks_reply
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

Not just check the return value but also that relay_addr
is valid. recv_socks_reply doesn't care whether the answer
is what we expected. This is probably a very unlikely edge
case but it doesn't hurt to check for it here.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#13
Change-Id: Ic1c8f24de423541bdc85e70b5a688213800d86de
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1469
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1469
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 078b4e1..5cb5912 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -412,8 +412,7 @@
             send(ctrl_sd, "\x05\x03\x00\x01\x00\x00\x00\x00\x00\x00", 10, MSG_NOSIGNAL);
         if (size != 10)
         {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "establish_socks_proxy_passthru: TCP port write failed on send()");
+            msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port write failed on send()", __func__);
             goto error;
         }
     }
@@ -424,6 +423,11 @@
     {
         goto error;
     }
+    if (!relay_addr->addr.in4.sin_addr.s_addr)
+    {
+        msg(D_LINK_ERRORS, "%s: Socks proxy did not answer with IPv4 address", __func__);
+        goto error;
+    }
 
     return;
 

