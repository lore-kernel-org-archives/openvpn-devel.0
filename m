From: Gert Doering <gert@...1296...>
Date: Thu, 31 Jul 2025 14:24:05 +0200
Message-ID: <20250731122410.12200-1-gert@...1296...>
In-Reply-To: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
References: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix DNS options duplication on
 PUSH_UPDATE
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

has removed reset of tuntap DNS options. Due to that, incoming --dns
options are added to existing ones instead of overwriting them.

It has also added a new storage for --dhcp-option. The push-update
code didn't clear it and as a result, incoming --dhcp-option options
were added to existing ones instead of overwriting them.

Fixed by:

 - resetting tuntap DNS options (regression from abovementioned commit)
 - clearing dhcp options storage in push-update code

GitHub: fixes OpenVPN/openvpn#804

Change-Id: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Heiko Hund <heiko@...515...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1121
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3753810..3ceada0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3527,7 +3527,13 @@
 #endif /* if defined(_WIN32) */
 
     /* Copy --dns options to tuntap_options */
+
     const struct dns_domain *d = dns->search_domains;
+    if (d)
+    {
+        tt->domain_search_list_len = 0;
+    }
+
     while (d && tt->domain_search_list_len + 1 < N_SEARCH_LIST_LEN)
     {
         tt->domain_search_list[tt->domain_search_list_len++] = d->name;
@@ -3538,6 +3544,9 @@
         msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to TUN/TAP");
     }
 
+    tt->dns_len = 0;
+    tt->dns6_len = 0;
+
     const struct dns_server *s = dns->servers;
     while (s)
     {
@@ -6212,6 +6221,8 @@
             }
             o->disable_nbt = 0;
             o->dhcp_options = 0;
+
+            CLEAR(options->dns_options.from_dhcp);
 #if defined(TARGET_ANDROID)
             o->http_proxy_port = 0;
             o->http_proxy = NULL;

