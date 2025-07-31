From: Gert Doering <gert@...1296...>
Date: Thu, 31 Jul 2025 12:48:27 +0200
Message-ID: <20250731104833.23305-1-gert@...1296...>
In-Reply-To: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
References: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix --dns options for TAP adapter
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

    2dfc4f ("dns: deal with --dhcp-options when --dns is active")

has accidentally removed setting of the DHCP_OPTIONS_DHCP_OPTIONAL
flag when copying --dns options. This flag is required to apply options
via DHCP string, which we do for TAP adapter. As a result, --dns options
stopped working for TAP.

Fix by setting this flag when copying --dns options to tuntap_options.

Change-Id: Id95cd14095a03afb3140a03ae96e9f5679e4fe89
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1120
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 53be6f5..3753810 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3579,6 +3579,7 @@
             {
                 msg(M_WARN, "WARNING: couldn't copy all --dns server addresses to TUN/TAP");
             }
+            tt->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
             return;
         }
     }

