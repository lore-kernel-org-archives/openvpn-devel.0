From: Gert Doering <gert@...1296...>
Date: Thu, 31 Jul 2025 17:29:06 +0200
Message-ID: <20250731152912.21826-1-gert@...1296...>
In-Reply-To: <gerrit.1753974592000.I37ca672f05e9d77ec586fa28dadc6dc752e574fb@...2715...>
References: <gerrit.1753974592000.I37ca672f05e9d77ec586fa28dadc6dc752e574fb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix wrong byte order of --dns server
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

We already fixed it in commit 82fd89a04f, but
the fix got lost in 2dfc4f8.

tuntap_options require host byte order, and we store
dns servers in struct dns_server in network byte order,
what we got from getaddrinfo().

Fix (again) by converting to the host byte order.

Change-Id: I37ca672f05e9d77ec586fa28dadc6dc752e574fb
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1125
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ceada0..ff9addd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3573,7 +3573,7 @@
             {
                 if (s->addr[i].family == AF_INET && tt->dns_len + 1 < N_DHCP_ADDR)
                 {
-                    tt->dns[tt->dns_len++] = s->addr[i].in.a4.s_addr;
+                    tt->dns[tt->dns_len++] = ntohl(s->addr[i].in.a4.s_addr);
                 }
                 else if (tt->dns6_len + 1 < N_DHCP_ADDR)
                 {

