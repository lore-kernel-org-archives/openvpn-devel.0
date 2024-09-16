From: Gert Doering <gert@...1296...>
Date: Mon, 16 Sep 2024 15:34:35 +0200
Message-ID: <20240916133436.29943-1-gert@...1296...>
In-Reply-To: <gerrit.1726491830000.I028634dba74a273c725b0beb16b674897b3c23fa@...2715...>
References: <gerrit.1726491830000.I028634dba74a273c725b0beb16b674897b3c23fa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Make read/write_tun_header static
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

From: Arne Schwabe <arne@...1227...>

These functions are not used outside tun.c

Change-Id: I028634dba74a273c725b0beb16b674897b3c23fa
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/745
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1f0eadd..0832375 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1822,7 +1822,7 @@
     }
 }
 
-int
+static int
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type == DEV_TYPE_TUN)
@@ -1855,7 +1855,7 @@
     }
 }
 
-int
+static int
 read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type == DEV_TYPE_TUN)

