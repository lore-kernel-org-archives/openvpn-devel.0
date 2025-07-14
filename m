From: Gert Doering <gert@...1296...>
Date: Mon, 14 Jul 2025 18:08:21 +0200
Message-ID: <20250714160903.7479-1-gert@...1296...>
In-Reply-To: <gerrit.1751514980000.Ide2cddad193c636eb440c9752751176dae0a6897@...2715...>
References: <gerrit.1751514980000.Ide2cddad193c636eb440c9752751176dae0a6897@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] prevent search domain races with macOS
 dns-updown
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

When connections go up and down there are situations where search
domains of a split DNS connection are either lost, or survive the
lifetime of the connction. This can happen when there is also a
connection that modifies the global DNS setting. When it backs-up the
global settings before modifying them, or when it restores the backup,
the search domains could contain or miss VPN domains from other
connections, leading to misconfiguration.

The fix is to also update the backed-up search domains when a split DNS
connection comes up or goes down. That way the backup is always up to
date and restoring it will keep the global search domains as expected.

Change-Id: Ide2cddad193c636eb440c9752751176dae0a6897
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1073
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
index c15abaa..f0640ee 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -29,14 +29,49 @@
 [ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
 
 itf_dns_key="State:/Network/Service/openvpn-${dev}/DNS"
-dns_backup_key="State:/Network/Service/openvpn-${dev}/DnsBackup"
-dns_backup_key_pattern="State:/Network/Service/openvpn-.*/DnsBackup"
 
 function primary_dns_key {
     local uuid=$(echo "show State:/Network/Global/IPv4" | /usr/sbin/scutil | grep "PrimaryService" | cut -d: -f2 | xargs)
     echo "Setup:/Network/Service/${uuid}/DNS"
 }
 
+function dns_backup_key {
+    local key="$(echo "list State:/Network/Service/openvpn-.*/DnsBackup" | /usr/sbin/scutil | cut -d= -f2 | xargs)"
+    if [[ "${key}" =~ no\ key ]]; then
+        echo "State:/Network/Service/openvpn-${dev}/DnsBackup"
+    else
+        echo "${key}"
+    fi
+}
+
+function property_value {
+    local key="$1"
+    local prop="$2"
+
+    [ -n "${key}" -a -n "${prop}" ] || return
+
+    local match_prop="${prop} : (.*)"
+    local match_array_start="${prop} : <array>"
+    local match_array_elem="[0-9]* : (.*)"
+    local match_array_end="}"
+    local in_array=false
+    local values=""
+
+    echo "show ${key}" | /usr/sbin/scutil | while read line; do
+        if [ "${in_array}" = false ] && [[ "${line}" =~ "${match_array_start}" ]]; then
+            in_array=true
+        elif [ "${in_array}" = true ] && [[ "${line}" =~ ${match_array_elem} ]]; then
+            values+="${BASH_REMATCH[1]} "
+        elif [ "${in_array}" = true ] && [[ "${line}" =~ "${match_array_end}" ]]; then
+            echo "${values}"
+            break
+        elif [[ "${line}" =~ ${match_prop} ]]; then
+            echo "${BASH_REMATCH[1]}"
+            break
+        fi
+    done
+}
+
 function only_standard_server_ports {
     local i=1
     while :; do
@@ -73,42 +108,52 @@
 }
 
 function get_search_domains {
-    local search_domains=""
-    local resolver=0
-    /usr/sbin/scutil --dns | while read line; do
-        if [[ "$line" =~ resolver.# ]]; then
-            resolver=$((resolver+1))
-        elif [ "$resolver" = 1 ] && [[ "$line" =~ search.domain ]]; then
-            search_domains+="$(echo $line | cut -d: -f2 | xargs) "
-        elif [ "$resolver" -gt 1 ]; then
-            echo "$search_domains"
-            break
-        fi
-    done
+    property_value State:/Network/Global/DNS SearchDomains
 }
 
 function set_search_domains {
     [ -n "$1" ] || return
-    dns_key=$(primary_dns_key)
-    search_domains="${1}$(get_search_domains)"
+    local dns_key=$(primary_dns_key)
+    local dns_backup_key="$(dns_backup_key)"
+    local search_domains="${1}$(get_search_domains)"
 
     local cmds=""
     cmds+="get ${dns_key}\n"
     cmds+="d.add SearchDomains * ${search_domains}\n"
     cmds+="set ${dns_key}\n"
+
+    if ! [[ "${dns_backup_key}" =~ ${dev}/ ]]; then
+        # Add the domains to the backup in case the default goes down
+        local existing="$(property_value ${dns_backup_key} SearchDomains)"
+        cmds+="get ${dns_backup_key}\n"
+        cmds+="d.add SearchDomains * ${search_domains} ${existing}\n"
+        cmds+="set ${dns_backup_key}\n"
+    fi
+
     echo -e "${cmds}" | /usr/sbin/scutil
 }
 
 function unset_search_domains {
     [ -n "$1" ] || return
-    dns_key=$(primary_dns_key)
-    search_domains="$(get_search_domains)"
+    local dns_key=$(primary_dns_key)
+    local dns_backup_key="$(dns_backup_key)"
+    local search_domains="$(get_search_domains)"
     search_domains=$(echo $search_domains | sed -e "s/$1//")
 
     local cmds=""
     cmds+="get ${dns_key}\n"
     cmds+="d.add SearchDomains * ${search_domains}\n"
     cmds+="set ${dns_key}\n"
+
+    if ! [[ "${dns_backup_key}" =~ ${dev}/ ]]; then
+        # Remove the domains from the backup for when the default goes down
+        search_domains="$(property_value ${dns_backup_key} SearchDomains)"
+        search_domains=$(echo $search_domains | sed -e "s/$1//")
+        cmds+="get ${dns_backup_key}\n"
+        cmds+="d.add SearchDomains * ${search_domains}\n"
+        cmds+="set ${dns_backup_key}\n"
+    fi
+
     echo -e "${cmds}" | /usr/sbin/scutil
 }
 
@@ -167,7 +212,8 @@
         echo -e "${cmds}" | /usr/sbin/scutil
         set_search_domains "$search_domains"
     else
-        echo list ${dns_backup_key_pattern} | /usr/sbin/scutil | grep -q 'no key' || {
+        local dns_backup_key="$(dns_backup_key)"
+        [[ "${dns_backup_key}" =~ ${dev}/ ]] || {
             echo "setting DNS failed, already redirecting to another tunnel"
             exit 1
         }
@@ -207,7 +253,8 @@
         unset_search_domains "$search_domains"
     else
         # Do not unset if this tunnel did not set/backup DNS before
-        echo list ${dns_backup_key} | /usr/sbin/scutil | grep -qv 'no key' || return
+        local dns_backup_key="$(dns_backup_key)"
+        [[ "${dns_backup_key}" =~ ${dev}/ ]] || return
 
         local cmds=""
         cmds+="get ${dns_backup_key}\n"

