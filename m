From: Gert Doering <gert@...1296...>
Date: Wed, 15 Nov 2023 13:06:23 +0100
Message-ID: <20231115120623.6442-1-gert@...1296...>
In-Reply-To: <gerrit.1699891289000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
References: <gerrit.1699891289000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Make --dns options apply for
 tap-windows6 driver
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

When tap-windows6 driver is used, both --dhcp-option and
--dns options are applied with DHCP. When processing --dns options,
we don't set "tuntap_options.dhcp_options" member, which is required
for DHCP string to be sent to the driver. As a result, --dns options
are not applied at all.

Fix by adding missing assignment of tuntap_options.dhcp_options.

Fixes https://github.com/OpenVPN/openvpn/issues/447

Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/427
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b88fea9..abd2e0c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1364,6 +1364,8 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to --dhcp-option");
         }
+
+        tt->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
     }
 
     if (dns->servers)
@@ -1401,6 +1403,7 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns server addresses to --dhcp-option");
         }
+        tt->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
     }
 }
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */

