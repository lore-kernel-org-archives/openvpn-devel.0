From: Gert Doering <gert@...1296...>
Date: Tue, 24 Dec 2024 18:42:33 +0100
Message-ID: <20241224174233.13005-1-gert@...1296...>
In-Reply-To: <gerrit.1735056384000.I87e4593e6a548bacd40b840cd241950019fa457d@...2715...>
References: <gerrit.1735056384000.I87e4593e6a548bacd40b840cd241950019fa457d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] repair DNS address option
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

Commit

  6f2d222 ("dns: store IPv4 addresses in network byte order")

changed the internal representation of IPv4 address within DNS
settings to network byte order, however later this value is copied into
tuntap_options, where IPv4 addresses are assumed to be in host byte
order (see lots of occurences of "htonl(tt->" in tun.c). As a
consequence, DNS server address is set incorrectly, like 4.4.8.8 instead
of 8.8.4.4

Fix by converting address to host byte order when copying from DNS
options to tuntap_options.

Change-Id: I87e4593e6a548bacd40b840cd241950019fa457d
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/845
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b2a3a8b..20e8d55 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1390,7 +1390,7 @@
                         overflow = true;
                         continue;
                     }
-                    tt->dns[tt->dns_len++] = server->addr[i].in.a4.s_addr;
+                    tt->dns[tt->dns_len++] = ntohl(server->addr[i].in.a4.s_addr);
                 }
                 else
                 {

