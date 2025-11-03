From: Gert Doering <gert@...1296...>
Date: Mon,  3 Nov 2025 12:59:40 +0100
Message-ID: <20251103115945.6615-1-gert@...1296...>
In-Reply-To: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
References: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: fix DNS address list generation
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

From: Heiko Hund <heiko@...2662...>

While generating the address list string for the DNS server addresses,
to be set in the registry, the offset is calculated the wrong way. This
results in gaps between addresses after the first two.

Reported-By: aarnav@...2953...

Change-Id: I7252d5a252e91ffc03db142aa226c9eb1656480b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1339
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1339
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 577d89c..58f1e02 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1873,7 +1873,7 @@
             {
                 RtlIpv4AddressToStringA(&msg->addr[i].ipv4, addrs + offset);
             }
-            offset += strlen(addrs);
+            offset = strlen(addrs);
         }
 
         err = SetNameServers(iid, msg->family, addrs);

