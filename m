From: Gert Doering <gert@...1296...>
Date: Wed, 30 Jul 2025 20:04:26 +0200
Message-ID: <20250730180527.25339-1-gert@...1296...>
In-Reply-To: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
References: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix broken DHCP options
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

broke support for --dhcp-options. It removed the setting of the
DHCP_OPTIONS_DHCP_OPTIONAL flag for some DHCP options. This flag is
required for those options to be applied correctly, as it is used
when building the DHCP options string that is passed to the TAP driver.

This commit fixes the issue by restoring the setting of this flag.

GitHub: fixes OpenVPN/openvpn#791

Change-Id: I0d75efcceb826d06e74abd003d5377468ff9fe3b
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1090
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0662b49..4ba9243 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8310,9 +8310,12 @@
 #endif
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
 
+        bool dhcp_optional = false;
+
         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")) && p[2] && !p[3])
         {
             dhcp->domain = p[2];
+            dhcp_optional = true;
         }
         else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
         {
@@ -8325,6 +8328,7 @@
                 msg(msglevel, "--dhcp-option %s: maximum of %d search entries can be specified",
                     p[1], N_SEARCH_LIST_LEN);
             }
+            dhcp_optional = true;
         }
         else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p[3]
                  && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
@@ -8336,6 +8340,7 @@
             else
             {
                 dhcp_option_address_parse("DNS", p[2], dhcp->dns, &dhcp->dns_len, msglevel);
+                dhcp_optional = true;
             }
         }
 #if defined(_WIN32) || defined(TARGET_ANDROID)
@@ -8359,6 +8364,7 @@
         else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len, msglevel);
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
@@ -8390,6 +8396,13 @@
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
         setenv_foreign_option(options, (const char **)p, 3, es);
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
+        if (dhcp_optional)
+        {
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
+#endif
+        }
     }
 #ifdef _WIN32
     else if (streq(p[0], "show-adapters") && !p[1])

