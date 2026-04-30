From: Gert Doering <gert@...1296...>
Date: Thu, 30 Apr 2026 14:40:14 +0200
Message-ID: <20260430124020.23066-1-gert@...1296...>
In-Reply-To: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
References: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dns: minimalist fix for dnssec setting
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

From: Selva Nair <selva.nair@...277...>

Github: fixes OpenVPN/openvpn#1024

Change-Id: I0cb093e0116e92d874162d51be777aa43674c115
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1644
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1644
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ce23f1f..954ed52 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -442,7 +442,7 @@
         .header = { (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg), sizeof(nrpt_dns_cfg_message_t),
                     0 },
         .iface = { .index = tt->adapter_index, .name = "" },
-        .flags = server->dnssec == DNS_SECURITY_NO ? 0 : nrpt_dnssec,
+        .flags = server->dnssec == DNS_SECURITY_YES ? nrpt_dnssec : 0,
     };
     strncpynt(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));
 

