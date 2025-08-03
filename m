From: Gert Doering <gert@...1296...>
Date: Sun,  3 Aug 2025 16:49:45 +0200
Message-ID: <20250803144950.21034-1-gert@...1296...>
In-Reply-To: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
References: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Log setting DNS via NRPT
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

Unlike other ways of setting DNS, we don't log anything
when we use NRPT. Since dco-win/--dns is the recommended
configuration and it uses NRPT to set DNS, let's log it.

Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1126
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ea3d91b..e079cd0 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -461,6 +461,11 @@
     make_domain_list("dns search domains", search_domains, false,
                      nrpt.search_domains, sizeof(nrpt.search_domains));
 
+    msg(D_LOW, "%s NRPT DNS%s%s on '%s' (if_index = %d) using service",
+        (add ? "Setting" : "Deleting"), nrpt.resolve_domains[0] != 0 ? ", resolve domains" : "",
+        nrpt.search_domains[0] != 0 ? ", search domains" : "",
+        nrpt.iface.name, nrpt.iface.index);
+
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
 

