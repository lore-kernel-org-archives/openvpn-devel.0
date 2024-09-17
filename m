From: Gert Doering <gert@...1296...>
Date: Tue, 17 Sep 2024 11:14:33 +0200
Message-ID: <20240917091433.24092-1-gert@...1296...>
In-Reply-To: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
References: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix check_addr_clash argument order
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

From: Ralf Lici <ralf@...2726...>

In init_tun() make sure to pass the --local and --remote addresses in
the host order so that they can be compared to the --ifconfig addresses.

Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/737
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 739e008..1cd6ad2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -877,9 +877,10 @@
             {
                 if (curele->ai_family == AF_INET)
                 {
+                    const in_addr_t local = ntohl(((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("local",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr,
+                                     local,
                                      tt->local,
                                      tt->remote_netmask);
                 }
@@ -889,9 +890,10 @@
             {
                 if (curele->ai_family == AF_INET)
                 {
+                    const in_addr_t remote = ntohl(((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("remote",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr,
+                                     remote,
                                      tt->local,
                                      tt->remote_netmask);
                 }

