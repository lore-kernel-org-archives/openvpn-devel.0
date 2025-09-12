From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 12 Sep 2025 15:22:35 +0200
Message-Id: <20250912132235.44304-1-frank@...2641...>
In-Reply-To: <gerrit.1757677796000.I815e68dd5d365743faff2b80783b776d9e8a645c@...2715...>
References: <gerrit.1757677796000.I815e68dd5d365743faff2b80783b776d9e8a645c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Preserve --dhcp-option values from local
 config
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit

  2dfc4f8 ("dns: deal with --dhcp-options when --dns is active")

has changed the way how --dhcp-option values are stored. Instead of
storing them directly in tuntap_options, they are now stored in
dns_options->from_dhcp.

Before connect, we save options before --pull is applied, for that
we call clone_dns_options(). However, this routing was missing cloning
of from_dhcp struct, and as a result, the values of --dhcp-option from'
the local config have been lost.

Fix by adding shallow-copying of dhcp_options to clone_dns_options(). It
is safe to do because it only contains fixed-size arrays, scalar types
and pointers to the strings which this struct doesn't own.

GitHub: https://github.com/OpenVPN/openvpn/issues/839

Change-Id: I815e68dd5d365743faff2b80783b776d9e8a645c
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1181
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 8554089..5421004 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -264,6 +264,7 @@
     clone.servers_prepull = clone_dns_servers(o->servers_prepull, gc);
     clone.updown = o->updown;
     clone.updown_flags = o->updown_flags;
+    clone.from_dhcp = o->from_dhcp;
 
     return clone;
 }

