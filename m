From: Gert Doering <gert@...1296...>
Date: Wed, 11 Feb 2026 12:33:10 +0100
Message-ID: <20260211113315.25776-1-gert@...1296...>
In-Reply-To: <gerrit.1770798406000.Ie5c9a88050de959cfb02e5f804323a8081ddb667@...2715...>
References: <gerrit.1770798406000.Ie5c9a88050de959cfb02e5f804323a8081ddb667@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] port-share: log incoming connections at
 verb 3 only
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

From "day 1" the message "Non-OpenVPN client protocol detected" was
logged at D_STREAM_ERRORS level (verb 1), while it is not anything
erroneous in this context (it's inside an "port share" only block).

Bump this to D_PS_PROXY (verb 3).

Github: closes OpenVPN/openvpn#976

Change-Id: Ie5c9a88050de959cfb02e5f804323a8081ddb667
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1516
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1516
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 58ccda9..d97b770 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2149,7 +2149,7 @@
         {
             if (!is_openvpn_protocol(&sb->buf))
             {
-                msg(D_STREAM_ERRORS, "Non-OpenVPN client protocol detected");
+                msg(D_PS_PROXY, "Non-OpenVPN client protocol detected");
                 sb->port_share_state = PS_FOREIGN;
                 sb->error = true;
                 return false;

