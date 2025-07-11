From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 11 Jul 2025 17:23:09 +0200
Message-Id: <20250711152309.286177-1-frank@...2641...>
In-Reply-To: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
References: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] mac dns: compare servers before
 restoring backup
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

From: Heiko Hund <heiko@...2662...>

In case anything changed the global DNS server addresses, while the
tunnel was connected, do not restore the backup of the global DNS
configuration we made when connecting. Doing so would likely change
DNS to something unexpected. Instead just clear the backup and leave
a message in the log.

Change-Id: I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1075
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
index 56f1009..73bbee9 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -111,6 +111,10 @@
     property_value State:/Network/Global/DNS SearchDomains
 }
 
+function get_server_addresses {
+    property_value "$(primary_dns_key)" ServerAddresses
+}
+
 function set_search_domains {
     [ -n "$1" ] || return
     local dns_key=$(primary_dns_key)
@@ -239,11 +243,10 @@
 
 function unset_dns {
     local n="$(find_compat_profile)"
-    local addresses="$(addresses_string $n)"
-    local search_domains="$(search_domains_string $n)"
     local match_domains="$(match_domains_string $n)"
 
     if [ -n "$match_domains" ]; then
+        local search_domains="$(search_domains_string $n)"
         echo "remove ${itf_dns_key}" | /usr/sbin/scutil
         unset_search_domains "$search_domains"
     else
@@ -252,8 +255,15 @@
         [[ "${dns_backup_key}" =~ ${dev}/ ]] || return
 
         local cmds=""
-        cmds+="get ${dns_backup_key}\n"
-        cmds+="set $(primary_dns_key)\n"
+        local servers="$(get_server_addresses)"
+        local addresses="$(addresses_string $n)"
+        # Only restore backup if the server addresses match
+        if [ "${servers}" = "${addresses}" ]; then
+            cmds+="get ${dns_backup_key}\n"
+            cmds+="set $(primary_dns_key)\n"
+        else
+            echo "not restoring global DNS configuration, server addresses have changed"
+        fi
         cmds+="remove ${dns_backup_key}\n"
         echo -e "${cmds}" | /usr/sbin/scutil
     fi

